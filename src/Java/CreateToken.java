package Java;

public class CreateToken {
	//파라미터에 따라 SHA1 인코딩된 문자열을 생성합니다. 
	public static String getHash(String[] args) {
		String hash = "";
		
		for(int i = 0; i < args.length; i++) {
			hash = hash + args[i] + args[i].substring(0,0);
		}
		
		hash = ByteUtils.toHexString(SHA1Utils.getHash(hash.getBytes()));
		
		return hash;
	}
}
