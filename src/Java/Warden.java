package Java;

public class Warden {
	//워든을 작동합니다. (백그라운드)
	
	public static void main(String[] args) {
		new Thread(new WardenFunction()).start();
	}
}
