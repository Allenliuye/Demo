package tw.eeit138.groupone.util.javamail;

public class PunchData3Month {

	// insert into punch values('1005','2022','12','25','09:30:29','17:30:29')
	public static void main(String[] args) {
		int emp1;
		int emp2 = 1017;
		
		for (emp1 = 1017; emp1 <= emp2; emp1++) {
			for (int year = 2022; year <= 2022; year++) {
				for (int m1 = 1; m1 <= 3; m1++) {
					for (int d1 = 1; d1 <= 9; d1++) {
						// 求 30~35 之間的亂數
						// 套亂數公式可以方便寫作，以min~MAX的範圍(min為亂數範圍的起始值，而MAX為亂數值範圍的終止值)：
						// 30~35亂數(分)
						int r35 = 0;
						r35 = (int) (Math.random() * (35 - 30 + 1)) + 30;

						// 10~59亂數(秒)
						int r59 = 0;
						r59 = (int) (Math.random() * (59 - 10 + 1)) + 10;
						System.out.println("insert into punch values('" + emp1 + "','" + year + "','" + "0" + m1 + "','0"
								+ d1 + "','09:" + r35 + ":" + r59 + "'," + "'17:" + r35 + ":" + r59 + "')");

					}
					for (int d2 = 10; d2 <= 30; d2++) {
						int r35 = 0;
						r35 = (int) (Math.random() * (35 - 30 + 1)) + 30;

						// 10~59亂數(秒)
						int r59 = 0;
						r59 = (int) (Math.random() * (59 - 10 + 1)) + 10;
						System.out.println("insert into punch values('" + emp1 + "','" + year + "','" + "0" + m1 + "','"
								+ d2 + "','09:" + r35 + ":" + r59 + "'," + "'17:" + r35 + ":" + r59 + "')");
					}
				}
			}
		}
	}

}
