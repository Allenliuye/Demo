package tw.eeit138.groupone.util;

import java.security.MessageDigest;
import java.util.Random;

/**
 * 採用MD5加密解密
 * 
 * @author hwd
 * @datetime 2014-03-20
 */
public class MD5Utils {

	/***
	 * MD5加碼 生成32位md5碼
	 */
	public static String string2MD5(String inStr) {
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			e.printStackTrace();
		}
		char[] charArray = inStr.toCharArray();
		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++)
			byteArray[i] = (byte) charArray[i];
		byte[] md5Bytes = md5.digest(byteArray);
		StringBuffer hexValue = new StringBuffer();
		for (int i = 0; i < md5Bytes.length; i++) {
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16)
				hexValue.append("0");
			hexValue.append(Integer.toHexString(val));
		}
		return hexValue.toString();

	}

	/**
	 * 加密解密演算法 執行一次加密,兩次解密
	 */
	public static String convertMD5(String inStr) {

		char[] a = inStr.toCharArray();
		for (int i = 0; i < a.length; i++) {
			a[i] = (char) (a[i] ^ 1);
		}
		String s = new String(a);
		return s;

	}

	// 隨機產生6位數
	public String randomCode() {
		StringBuilder str = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < 6; i++) {
			str.append(random.nextInt(10));
		}
		return str.toString();
	}

	// 生成隨機數字和字母,
	public String getStringRandom(int length) {

		String val = "";
		Random random = new Random();

		// 參數length，表示生成幾位隨機數
		for (int i = 0; i < length; i++) {

			String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";
			// 輸出字母還是數字
			if ("char".equalsIgnoreCase(charOrNum)) {
				// 輸出是大寫字母還是小寫字母
				int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;
				val += (char) (random.nextInt(26) + temp);
			} else if ("num".equalsIgnoreCase(charOrNum)) {
				val += String.valueOf(random.nextInt(10));
			}
		}
		return val;
	}

	public static void main(String args[]) {
		MD5Utils utils = new MD5Utils();
		
		String s = new String(utils.getStringRandom(6) + "Passw0rd123@" + utils.getStringRandom(7));
		String s1 = new String("wong2wai3dah123");
		System.out.println("原始:" + s);
		System.out.println("MD5後:" + string2MD5(s));
		System.out.println("MD5後:" + string2MD5(s1));
		System.out.println("加密的:" + convertMD5(s));
		System.out.println("解密的:" + convertMD5(convertMD5(s)));

	}
}
