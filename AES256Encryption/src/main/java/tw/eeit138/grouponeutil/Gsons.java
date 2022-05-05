package tw.eeit138.grouponeutil;

public class Gsons {

	private String key;
	
	private String value;

	/**
	 * @return the value
	 */

	public String getValue() {
		return value;
	}

	/**
	 * @return the key
	 */
	public String getKey() {
		return key;
	}

	/**
	 * @param key the key to set
	 */
	public void setKey(String key) {
		this.key = key;
	}

	/**
	 * @param value the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}



	@Override
	public String toString() {
		return key + ":" + value;
	}

}
