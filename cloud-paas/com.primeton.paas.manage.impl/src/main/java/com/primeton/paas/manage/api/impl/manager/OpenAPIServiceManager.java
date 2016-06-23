/**
 * 
 */
package com.primeton.paas.manage.api.impl.manager;

import com.primeton.paas.manage.api.exception.ServiceException;
import com.primeton.paas.manage.api.manager.IOpenAPIServiceManager;
import com.primeton.paas.manage.api.model.IService;
import com.primeton.paas.manage.api.service.OpenAPIService;

/**
 *
 * @author liyanping(liyp@primeton.com)
 */
public class OpenAPIServiceManager extends DefaultServiceManager 
		implements IOpenAPIServiceManager {

	public static final String TYPE = OpenAPIService.TYPE;
	
	public OpenAPIServiceManager(){
		super();
	}

	/* (non-Javadoc)
	 * @see com.primeton.paas.manage.api.impl.manager.DefaultServiceManager#getType()
	 */
	public String getType() {
		return TYPE;
	}

	/* (non-Javadoc)
	 * @see com.primeton.paas.manage.api.impl.manager.DefaultServiceManager#add(com.primeton.paas.manage.api.model.IService, java.lang.String)
	 */
	public <T extends IService> T add(T service, String clusterId)
			throws ServiceException {
		return super.create(service, clusterId);
	}
	
}
