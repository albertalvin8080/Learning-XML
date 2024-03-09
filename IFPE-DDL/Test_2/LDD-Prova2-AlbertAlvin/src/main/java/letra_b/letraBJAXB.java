package letra_b;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;

import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.Marshaller;
import jakarta.xml.bind.Unmarshaller;

public class letraBJAXB {
	public static void main(String[] args) throws Exception {
		JAXBContext ctx = JAXBContext.newInstance(Population.class);
		
		// xml para objeto
		Unmarshaller um = ctx.createUnmarshaller();
		Population p = (Population) um.unmarshal(new File("./xmls/letra_a.xml"));
		
		// objeto de volta para xml
		Marshaller m = ctx.createMarshaller();
		m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
		FileWriter w = new FileWriter(new File("./xmls/letra_b.xml"));
		m.marshal(p, w);
	}
}
