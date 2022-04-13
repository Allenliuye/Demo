package tw.eeit138.groupone.util.javamail;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.google.zxing.EncodeHintType;
import com.google.zxing.NotFoundException;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import tw.eeit138.groupone.util.QRCodeTool;

public class QRCodeToolTest {

	public static void main(String[] args) throws WriterException, IOException,
			NotFoundException {
		// 二維碼字串
		String qrCodeData = "https://www.baidu.com/";
		// 二維碼名稱
		File file = new File("");
		
		String filePath = file.getAbsolutePath() + "\\src\\main\\webapp\\src\\img\\EmpImg\\QR.png";
		// 字元編碼
		String charset = "UTF-8"; // "ISO-8859-1"
		Map hintMap = new HashMap();
		hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
		QRCodeTool.createQRCode(qrCodeData, filePath, charset, hintMap, 400,
				400);
		
		System.out.println("二維碼影象建立成功!");

		System.out.println("讀取二維碼資料: "
				+ QRCodeTool.readQRCode(filePath, charset, hintMap));
	}

}
