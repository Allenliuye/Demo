package tw.eeit138.groupone.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import tw.eeit138.groupone.model.EmployeeBean;

public class GenerateLinkUtils {

	private static final String CHECK_CODE = "cheakCode";
	
	//生成重設密碼連結
	public static String generateResetpwdLink(EmployeeBean emp) {
	return "http://localhost:8080/GroupOne/resetPassword?empId="
	+ emp.getEmpId() + "&" + CHECK_CODE + "=" + generateCheckcode(emp);
	}
	
	//生成驗證帳戶的MD5驗證碼
	//要激活的emp帳戶
	//return將用戶名和密碼組合後,通過md5加密後的16進位制格式的字串
	public static String generateCheckcode(EmployeeBean emp) {
			String username = emp.getUsername();
			String boardDate = emp.getBoardDate();
			return md5(username + ":" + boardDate);
			}
	
	
	private static String md5(String string) {
			MessageDigest md = null;
			try {
			md = MessageDigest.getInstance("md5");
			md.update(string.getBytes());
			byte[] md5Bytes = md.digest();
			return bytes2Hex(md5Bytes);
			}
			catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			}
			return null;
	}
	
	private static String bytes2Hex(byte[] byteArray) {
	StringBuffer strBuf = new StringBuffer();
	for (int i = 0; i < byteArray.length; i++) {
	if(byteArray[i] >= 0 && byteArray[i] <16) {
	strBuf.append("0");
	}
	strBuf.append(Integer.toHexString(byteArray[i] & 0xFF));
	}
	return strBuf.toString();
	}
}
