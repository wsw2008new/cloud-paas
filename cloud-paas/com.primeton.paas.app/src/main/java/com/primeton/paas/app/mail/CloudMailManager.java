/**
 * 
 */
package com.primeton.paas.app.mail;

import com.primeton.paas.app.api.mail.IMail;
import com.primeton.paas.app.api.mail.IMailManager;
import com.primeton.paas.app.api.mail.MailException;
import com.primeton.paas.app.api.mail.MailResult;

/**
 * @author ZhongWen.Li (mailto:lizw@primeton.com)
 *
 */
public class CloudMailManager implements IMailManager {

	/**
	 * Default. <br>
	 */
	public CloudMailManager() {
		super();
	}

	/* (non-Javadoc)
	 * @see com.primeton.paas.app.api.mail.IMailManager#syncSend(com.primeton.paas.app.api.mail.IMail)
	 */
	public MailResult syncSend(IMail mail) throws MailException {
		return CloudMailUtil.syncSend(mail);
	}

	/* (non-Javadoc)
	 * @see com.primeton.paas.app.api.mail.IMailManager#asyncSend(com.primeton.paas.app.api.mail.IMail)
	 */
	public void asyncSend(IMail mail) throws MailException {
		CloudMailUtil.asyncSend(mail);
	}

}
