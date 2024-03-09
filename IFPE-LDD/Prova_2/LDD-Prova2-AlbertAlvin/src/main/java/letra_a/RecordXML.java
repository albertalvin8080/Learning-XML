package letra_a;

public class RecordXML implements Comparable<RecordXML> {
	private long year;
	private long population; // value
	private String type;
	
	@Override
	public int compareTo(RecordXML o) {
		if(population == 0) {
			return 0;
		}
		return year < o.year ? 0 : 1;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public long getYear() {
		return year;
	}

	public void setYear(long year) {
		this.year = year;
	}

	public long getPopulation() {
		return population;
	}

	public RecordXML(long year, long population) {
		super();
		this.year = year;
		this.population = population;
	}
	
	public RecordXML() {}

	public void setPopulation(long population) {
		this.population = population;
	}

	@Override
	public String toString() {
		return "RecordXML [year=" + year + ", population=" + population + "]";
	}
}
