/**
 * 
 */
package com.primeton.upcloud.ws.api;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * @author liming(mailto:li-ming@primeton.com)
 *
 */
public class DBJobResult {
	
	public static final String STATUS_SUCCESS = "SUCCESS";
	public static final String STATUS_PENDING = "PENDING";
	public static final String STATUS_FAIL = "FAIL";
	
	private String id;
	private String status;
	private String message;
	private List<DBServer> servers = new ArrayList<DBServer>();

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * @return the servers
	 */
	public List<DBServer> getServers() {
		return servers;
	}

	/**
	 * @param servers the servers to set
	 */
	public void setServers(List<DBServer> servers) {
		if (servers == null) {
			this.servers.clear();
		} else {
			this.servers = servers;
		}
	}

	public void addServer(DBServer server) {
		if (server != null && !this.servers.contains(server)) {
			this.servers.add(server);
		}
	}
	
	public <T extends DBServer> void addServices(Collection<T> servers) {
		if (servers != null) {
			this.servers.addAll(servers);
		}
	}
	
	public void remove(VServer server) {
		this.servers.remove(server);
	}
	
	public void clear() {
		this.servers.clear();
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return "DBJobResult [id=" + id + ", status=" + status + ", message="
				+ message + ", servers=" + servers + "]";
	}

}