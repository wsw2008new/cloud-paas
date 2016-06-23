/**
 * 
 */
package com.primeton.paas.manage.api.factory;

import java.util.Iterator;
import java.util.List;

import org.gocom.cloud.common.logger.api.ILogger;
import org.gocom.cloud.common.utility.api.ServiceExtensionLoader;

import com.primeton.paas.manage.api.manager.IVariableManager;
import com.primeton.paas.manage.api.util.ExceptionUtil;

/**
 * @author lizhongwen(mailto:lizw@primeton.com)
 *
 */
public class VariableManagerFactory {

	private static ILogger logger = ManageLoggerFactory
			.getLogger(VariableManagerFactory.class);

	private VariableManagerFactory() {
	}

	private static IVariableManager manager;

	/**
	 * 
	 * @return
	 */
	public static synchronized IVariableManager getManager() {
		if (null == manager) {
			ServiceExtensionLoader<IVariableManager> loader = ServiceExtensionLoader
					.load(IVariableManager.class);
			if (loader != null) {
				List<Throwable> errorList = loader.getErrorList();
				if (errorList.size() > 0) {
					logger.error("The Factory mistakes, prompt error ["
							+ ExceptionUtil.getCauseMessage(errorList.get(0))
							+ "]");
				} else {
					Iterator<IVariableManager> iterator = loader.iterator();
					while (iterator.hasNext()) {
						return manager = iterator.next();
					}
				}
			}
		}
		return manager;
	}

}