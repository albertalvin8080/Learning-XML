package letra_a;

import java.io.File;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.Serializer.Property;

public class LetraASAX extends DefaultHandler {
	public Map<String, List<RecordXML>> map = new LinkedHashMap<>();
	private RecordXML tempRecordXML = new RecordXML();
	private String tempCountryRegion = "";
	private boolean bCountry;
	private boolean bRegion;
	private boolean bValue;
	private boolean bYear;

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
		if ("field".equals(qName)) {
			switch (attributes.getValue("name")) {
			case "Region":
				bRegion = true;
				break;
			case "Country":
				bCountry = true;
				break;
			case "Year":
				bYear = true;
				break;
			case "Value":
				bValue = true;
				break;
			}
		}
	}

	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		if(bCountry) {
			tempCountryRegion += new String(ch, start, length)
					.replaceAll("\\n+", "").replaceAll("\\s+", " ");
		} else if(bRegion) {
			// lidando com nomes estranhos como "South Asia (IDA &amp; IBRD)"
			tempCountryRegion += new String(ch, start, length)
					.replaceAll("\\n+", "").replaceAll("\\s+", " ");
		} else if (bYear) {
			bYear = false;
			tempRecordXML.setYear(Long.parseLong(new String(ch, start, length)));
		} else if (bValue) {
			bValue = false;
			String temp = new String(ch, start, length).trim();
			tempRecordXML.setPopulation(
					Long.parseLong(temp.equals("") ? "0" : temp));
		}
	}

	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException {
		if(bCountry) {
			tempRecordXML.setType("country");
			bCountry = false;
		}else if(bRegion) {
			tempRecordXML.setType("region");
			bRegion = false;
		}
		else if (qName.equals("record")) {
			List<RecordXML> list = map.get(tempCountryRegion);
			if (list == null) {
				list = new ArrayList<>();
			}
			list.add(tempRecordXML);
			map.put(tempCountryRegion.trim(), list);
			tempRecordXML = new RecordXML();
			tempCountryRegion = "";
		}
	}

	public static void main(String[] args) throws Exception {
		File file = new File("./population.xml");
		LetraASAX handler = new LetraASAX();

		SAXParser parser = SAXParserFactory.newInstance().newSAXParser();
		parser.parse(file, handler);
		
		var s = new Processor().newSerializer(new File("./xmls/letra_a.xml"));
		s.setOutputProperty(Property.INDENT, "yes");
		s.setOutputProperty(Property.METHOD, "xml");
		XMLStreamWriter w = s.getXMLStreamWriter();
		
		w.writeStartDocument();
		w.writeStartElement("population");
		
		handler.map.forEach((k, v) -> {
			try {
				w.writeStartElement("record");
				for(int i = 0; i < v.size(); ++i) {
					var r = v.get(i);
					if(i == 0) {
						w.writeAttribute(r.getType(), k);						
					}
					
					w.writeStartElement("value");
					w.writeAttribute("year", String.valueOf(r.getYear()));
					
					var population = r.getPopulation();
					if(population > 0) {
						w.writeCharacters(String.valueOf(population));						
					}
					
					w.writeEndElement(); // value
				}
				w.writeEndElement(); // record
			} catch (XMLStreamException e) {
				e.printStackTrace();
			}
		});
		
		w.writeEndElement(); // population
		w.writeEndDocument();
		
//		fos.close();
		w.close();
	}
}
