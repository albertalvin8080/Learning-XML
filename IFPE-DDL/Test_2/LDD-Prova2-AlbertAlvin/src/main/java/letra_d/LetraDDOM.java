package letra_d;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class LetraDDOM {

	public static void main(String[] args) throws Exception {
		DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		Document doc = builder.parse("./xmls/letra_a.xml");

		XPath xpath = XPathFactory.newInstance().newXPath();

		NodeList nodes = (NodeList) xpath.compile("//@year").evaluate(doc, XPathConstants.NODESET);

		TreeSet<Integer> yearSet = IntStream.range(0, nodes.getLength()).mapToObj(i -> nodes.item(i))
				.map(node -> Integer.parseInt(node.getTextContent())).collect(Collectors.toCollection(TreeSet::new));

		Document newDoc = builder.newDocument();
		Element root = newDoc.createElement("root");
		newDoc.appendChild(root);
		
		for (int year : yearSet) {
			
			NodeList countries = (NodeList) xpath
					.compile("//record/value[. > 100000000 and @year = '%d']/parent::record/@country"
							.formatted(year))
					.evaluate(doc, XPathConstants.NODESET);

			List<String> sortedCountries = new ArrayList<>();
			for (int i = 0; i < countries.getLength(); ++i) {
				sortedCountries.add(countries.item(i).getTextContent());
			}
//			sortedCountries.sort(Comparator.comparing(String::toString));

			Element ul = newDoc.createElement("ul");
			ul.setAttribute("year", String.valueOf(year));
			ul.setAttribute("count", String.valueOf(sortedCountries.size()));
			sortedCountries.forEach(c -> {
				Element li = newDoc.createElement("li");
				li.setTextContent(c);
				ul.appendChild(li);
			});
			root.appendChild(ul);
		}
		
		prettyPrint(newDoc);
	}
	
	private static void prettyPrint(Document doc) throws Exception {
		Transformer t = TransformerFactory.newInstance().newTransformer();
		t.setOutputProperty(OutputKeys.INDENT, "yes");
		t.setOutputProperty(OutputKeys.METHOD, "xml");
		t.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
		
		StreamResult sr = new StreamResult(new File("./xmls/letra_d.xml"));
		DOMSource domSource = new DOMSource(doc);
		
		t.transform(domSource, sr);
	}

}
