package letra_b;

import java.util.List;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlAttribute;
import jakarta.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
public class Record {
	@XmlAttribute
	private String country;
	@XmlAttribute
	private String region;
	@XmlElement(name = "value")
	List<Value> values;
}
