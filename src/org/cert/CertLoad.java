package org.cert;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import java.util.Map.Entry;

public class CertLoad {
	HttpServletRequest mRequest;
	List<X509Certificate> mList;
	
	public CertLoad(HttpServletRequest mRequest, String mType) throws Exception {
		/* mType : "local" or Else */
		this.mRequest = mRequest;
		if(mType == "local")
			mList = loadCertificateLocal();
		else
			mList = loadCertificateServer();
	}
	
	private List<X509Certificate> loadCertificateServer() throws Exception {
		return null;
	}
	
	private List<X509Certificate> loadCertificateLocal() throws Exception {
		List<X509Certificate> certificates = new ArrayList<X509Certificate>();
		Properties CERT_PATH = new Properties();
		CERT_PATH.load(
				mRequest.getServletContext().getResourceAsStream("/PROPERTIES/CERT_PATH.properties")
		);
		for(Entry<Object, Object> CERT_PATH_ENTRY : CERT_PATH.entrySet()) {
			File firstFile = new File((String) CERT_PATH_ENTRY.getValue()).listFiles()[0];
			for(File nextFile : firstFile.listFiles()) {
				if(!nextFile.getName().equals("signCert.der"))
					continue;
				certificates.add(CertUtil.mkCertificate(nextFile));
			}
		}
		return certificates;
	}
	
	public ArrayList<String> getPrincipalValues(String fields) throws Exception {
		/* CN=Duke, OU=JavaSoft, O=Sun Microsystems, C=US */ 
		ArrayList<String> resultList = new ArrayList<String>();
		
		for(X509Certificate mListItem : mList) {
			resultList.add(
					CertUtil.getPrincipalMap(mListItem.getIssuerX500Principal().getName("RFC2253")).get(fields)
			);
		}
		return resultList;
	}
}
