/**
 * 
 */
package com.primeton.paas.app;

import java.io.File;

import org.gocom.cloud.common.utility.api.SystemProperties;

import com.primeton.paas.app.util.NetUtil;
import com.primeton.paas.app.util.StringUtil;

/**
 * 服务器上下文. <br>
 * 
 * @author ZhongWen.Li (mailto:lizw@primeton.com)
 *
 */
public class ServerContext {

	private static ServerContext instance = new ServerContext();

	/** server instance id */
	private String instId;
	
	/** server type */
	private String srvType;
	
	/** cluster name */
	private String clusterName;

	/** server ip address */
	private String ip;

	/** server http port */
	private int httpPort;

	/** server jmx port */
	//	private int jmxPort;

	/** application name */
	private String appName;
	
	/** war name */
	private String warName;

	/** server instance working dir */
	private String workDir;
	
	/** server log dir */
	private String logDir;
	
	/** jetty home */
	private String serverHome;
	
	/** file root dir */
	private String fileRootDir;

	/** The war real path. */
	private String warRealPath = null; // WAR Path

	/** The web context path. */
	private String webContextPath = null; // Web Context Path

	/** config files dir path */
	private String configDirPath = null;

	/** is server startup */
	private boolean started = false;
	
	private int runMode = 0;

	private String runModeString;

	private ServerContext() {
		this.ip = SystemProperties.getProperty(AppConstants.ENV_IP);
		if (this.ip == null || this.ip.equals("0.0.0.0")) {
			this.ip = NetUtil.getLocalHostIPAddress();
		}
		//	this.jmxPort = Integer.parseInt(System.getProperty("jetty.jmxrmiport"));
		this.httpPort = SystemProperties.getProperty(AppConstants.ENV_HTTP_PORT, Integer.class);
		this.instId = SystemProperties.getProperty(AppConstants.ENV_INST_ID);
		this.srvType = SystemProperties.getProperty(AppConstants.ENV_SRV_TYPE);
		this.clusterName = SystemProperties.getProperty(AppConstants.ENV_CLUSTER_NAME);
		this.serverHome = SystemProperties.getProperty(AppConstants.ENV_SERVER_HOME);
		this.workDir = SystemProperties.getProperty(AppConstants.ENV_WORK_DIR);
		this.appName = SystemProperties.getProperty(AppConstants.ENV_APP_NAME);
		this.fileRootDir = SystemProperties.getProperty(AppConstants.ENV_FILE_ROOT_DIR);
	}

	/**
	 * 
	 * @return
	 */
	public static ServerContext getInstance() {
		return instance;
	}

	public String getInstId() {
		return instId;
	}
	
	public String getSrvType() {
		return srvType;
	}
	
	public String getClusterName() {
		return clusterName;
	}
	
	public String getWarRealPath() {
		return warRealPath;
	}

	public void setWarRealPath(String warRealPath) {
		this.warRealPath = warRealPath;
	}

	public String getWebContextPath() {
		return webContextPath;
	}

	public void setWebContextPath(String webContextPath) {
		this.webContextPath = webContextPath;
	}

	public String getWarName() {
		return warName;
	}

	public void setWarName(String warName) {
		this.warName = warName;
	}
	
	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public boolean isStarted() {
		return started;
	}

	public void setStarted(boolean started) {
		this.started = started;
	}

	public String getIp() {
		return ip;
	}

	public int getHttpPort() {
		return httpPort;
	}

	/**
	 * 
	 * @return
	 */
	public String getWorkDir() {
		return workDir;
	}
	
	/**
	 * 
	 * @return
	 */
	public String getLogDir() {
		return logDir;
	}
	
	/**
	 * 
	 * @return
	 */
	public String getServerHome() {
		return serverHome;
	}
	
	/**
	 * 
	 * @return
	 */
	public String getFileRootDir() {
		return fileRootDir;
	}

	/**
	 * 
	 * @return
	 */
	public boolean hasExternalDir() {
		if (!StringUtil.isEmpty(this.workDir)) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 
	 * @return
	 */
	public String getConfigDirPath() {
		if (!StringUtil.isEmpty(configDirPath))
			return configDirPath;

		if (!StringUtil.isEmpty(this.workDir) && !StringUtil.isEmpty(this.warName)) {
			this.configDirPath = this.workDir + File.separator + this.warName + File.separator + "config";

		} else {
			if (!StringUtil.isEmpty(warRealPath)) {
				this.configDirPath = this.warRealPath + File.separator + "WEB-INF" + File.separator + "config";
			}
		}
		return configDirPath;
	}

	/**
	 * 
	 * @return
	 */
	public String getDefaultConfigDirPath() {
		return this.warRealPath + File.separator + "WEB-INF" + File.separator + "config"; //$NON-NLS-1$ //$NON-NLS-2$
	}
	
	/**
	 * 
	 * @return
	 */
	public int getRunMode() {
		if (runMode != 0) {
			return runMode;
		}
		runModeString = SystemProperties.getProperty(AppConstants.ENV_RUN_MODE, AppConstants.RUN_MODE_DEVELOP);
		if (AppConstants.RUN_MODE_DEVELOP.equals(runModeString)) {
			runMode = AppConstants.RUN_MODE_SIMULATOR;
		} else if (AppConstants.RUN_MODE_PRODUCT.equals(runModeString)) {
			runMode = AppConstants.RUN_MODE_CLOUD;
		} else {
			throw new IllegalStateException("The Application RUN_MODE '" + runModeString + "' is invalid.");
		}
		return runMode;
	}

}