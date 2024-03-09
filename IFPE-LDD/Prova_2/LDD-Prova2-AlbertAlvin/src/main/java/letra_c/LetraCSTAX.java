package letra_c;

import java.io.File;
import java.io.FileReader;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamReader;
import javax.xml.stream.XMLStreamWriter;

import letra_a.RecordXML;
import net.sf.saxon.expr.PJConverter.StringItemToChar;
import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.Serializer;
import net.sf.saxon.s9api.Serializer.Property;

public class LetraCSTAX {

	public static void main(String[] args) throws Exception {
		FileReader fr = new FileReader(new File("./xmls/letra_a.xml"));
		XMLStreamReader xsr = XMLInputFactory.newInstance().createXMLStreamReader(fr);

		Map<String, List<RecordXML>> map = new HashMap<>();
		RecordXML tempRecordXML = new RecordXML();
		String countryRegion = null;
		boolean bValue = false;

		while (xsr.hasNext()) {
			switch (xsr.next()) {
			case XMLStreamConstants.START_ELEMENT -> {
				if (xsr.getLocalName().equals("record")) {
					countryRegion = xsr.getAttributeValue(null, "country");
					if (countryRegion == null) {
						countryRegion = xsr.getAttributeValue(null, "region");
						tempRecordXML.setType("region");
					} else {
						tempRecordXML.setType("country");
					}
//					System.out.println(countryRegion);
				} else if (xsr.getLocalName().equals("value")) {
					bValue = true;
					tempRecordXML.setYear(Long.parseLong(xsr.getAttributeValue(null, "year")));
				}
			}
			case XMLStreamConstants.CHARACTERS -> {
				if (bValue) {
					bValue = false;
					String temp = xsr.getText().replaceAll("\\s+", "");
					tempRecordXML.setPopulation(Long.parseLong(temp.equals("") ? "0" : temp));
				}
			}
			case XMLStreamConstants.END_ELEMENT -> {
				if (xsr.getLocalName().equals("value")) {
					List<RecordXML> list = map.get(countryRegion);
					if (list == null) {
						list = new ArrayList<>();
					}
					list.add(tempRecordXML);
					map.put(countryRegion, list);
					tempRecordXML = new RecordXML();
				} else if (xsr.getLocalName().equals("record")) {
					countryRegion = null;
				}
			}
			}
		}

		DecimalFormat formatter = new DecimalFormat("#,###.00");

		String aCountry = null;
		String rCountry = null;
		double absolute = -1;
		double relative = -1;

		for (Map.Entry<String, List<RecordXML>> entry : map.entrySet()) {
			String key = entry.getKey();
			List<RecordXML> list = entry.getValue();

			if (!list.get(0).getType().equals("country")) {
				continue;
			}

			RecordXML menorAno = Collections.min(list);
			RecordXML maiorAno = Collections.max(list);

			double popIni = menorAno.getPopulation();
			double popFinal = maiorAno.getPopulation();

			double tempAbsolute = popFinal - popIni;
			if (absolute < tempAbsolute) {
				absolute = tempAbsolute;
				aCountry = key;
			}

			if (popIni == 0)
				continue;
			double tempRelative = (popFinal - popIni) / popIni * 100;
			if (relative < tempRelative) {
				relative = tempRelative;
				rCountry = key;
			}
		}

		Serializer s = new Processor().newSerializer(new File("./xmls/letra_c.xml"));
		s.setOutputProperty(Property.INDENT, "yes");
		s.setOutputProperty(Property.METHOD, "xml");
		XMLStreamWriter w = s.getXMLStreamWriter();

		w.writeStartDocument();
		w.writeStartElement("result");

		w.writeStartElement("relative");
		w.writeAttribute("country", rCountry);
		w.writeAttribute("value", formatter.format(relative) + "%");
		w.writeEndElement(); // relative

		w.writeStartElement("absolute");
		w.writeAttribute("country", aCountry);
		w.writeAttribute("value", formatter.format(absolute));
		w.writeEndElement(); // absolute

		w.writeEndElement(); // result
		w.writeEndDocument();

		xsr.close();
		fr.close();
		w.close();
	}

}
