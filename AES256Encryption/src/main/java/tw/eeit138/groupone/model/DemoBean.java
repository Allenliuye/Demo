package tw.eeit138.groupone.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "Table1")
public class DemoBean implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idx;
	
	private String  c_aes256;
	
	private String  c_base64;
	
	
	@Override
	public String toString() {
		return "DemoBean [idx=" + idx + ", c_aes256=" + c_aes256 + ", c_base64=" + c_base64 + "]";
	}


	
	
	public DemoBean() {
		
	}
	


	public int getIdx() {
		return idx;
	}


	public void setIdx(int idx) {
		this.idx = idx;
	}


	public String getC_aes256() {
		return c_aes256;
	}


	public void setC_aes256(String c_aes256) {
		this.c_aes256 = c_aes256;
	}


	public String getC_base64() {
		return c_base64;
	}


	public void setC_base64(String c_base64) {
		this.c_base64 = c_base64;
	}
	
	
}
