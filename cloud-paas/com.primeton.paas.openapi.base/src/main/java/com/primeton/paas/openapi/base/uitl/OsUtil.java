/**
 * 
 */
package com.primeton.paas.openapi.base.uitl;

import java.util.Locale;

/**
 * 
 * @author ZhongWen.Li (mailto:lizw@primeton.com)
 *
 */
public final class OsUtil {

	/** The Constant ENCODING. */
	private static final String ENCODING = System.getProperty("file.encoding");

	/** The Constant OS_NAME. */
	private static final String OS_NAME = System.getProperty("os.name").toLowerCase(Locale.US);

	/** The Constant OS_ARCH. */
	private static final String OS_ARCH = System.getProperty("os.arch").toLowerCase(Locale.US);

	/** The Constant OS_VERSION. */
	private static final String OS_VERSION = System.getProperty("os.version").toLowerCase(Locale.US);

	/** The Constant PATH_SEP. */
	private static final String PATH_SEP = System.getProperty("path.separator");

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_WINDOWS = "windows";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_9X = "win9x";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_NT = "winnt";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_OS2 = "os/2";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_NETWARE = "netware";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_DOS = "dos";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_MAC = "mac";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_TANDEM = "tandem";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_UNIX = "unix";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_VMS = "openvms";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_ZOS = "z/os";

	/** OS family that can be tested for. {@value} */
	public static final String FAMILY_OS400 = "os/400";

	private OsUtil() {
		super();
	}

	public static boolean isFamily(String family) {
		return isOs(family, null, null, null);
	}

	/**
	 * Determines if the OS on which Ant is executing matches the
	 * given OS name.
	 *
	 * @param name  The OS family type desired<br />
	 * Possible values:<br />
	 * <ul>
	 * <li>dos</li>
	 * <li>mac</li>
	 * <li>netware</li>
	 * <li>os/2</li>
	 * <li>tandem</li>
	 * <li>unix</li>
	 * <li>windows</li>
	 * <li>win9x</li>
	 * <li>z/os</li>
	 * <li>os/400</li>
	 * </ul>
	 *
	 * @return true if the OS matches
	 *
	 * @since 1.7
	 */
	public static boolean isName(String name) {
		return isOs(null, name, null, null);
	}

	/**
	 * Determines if the OS on which Ant is executing matches the
	 * given OS architecture.
	 *
	 * @param arch the OS architecture to check for
	 *
	 * @return true if the OS matches
	 *
	 * @since 1.7
	 */
	public static boolean isArch(String arch) {
		return isOs(null, null, arch, null);
	}

	/**
	 * Determines if the OS on which Ant is executing matches the
	 * given OS version.
	 *
	 * @param version the OS version to check for
	 *
	 * @return true if the OS matches
	 *
	 * @since 1.7
	 */
	public static boolean isVersion(String version) {
		return isOs(null, null, null, version);
	}

	/**
	 * Determines if the OS on which Ant is executing matches the
	 * given OS family, name, architecture and version.
	 *
	 * @param family   The OS family
	 * @param name   The OS name
	 * @param arch   The OS architecture
	 * @param version   The OS version
	 *
	 * @return true if the OS matches
	 *
	 * @since 1.7
	 */
	public static boolean isOs(String family, String name, String arch, String version) {

		boolean retValue = false;

		if (family != null || name != null || arch != null || version != null) {

			boolean isFamily = true;
			boolean isName = true;
			boolean isArch = true;
			boolean isVersion = true;

			if (family != null) {
				family = family.toLowerCase();
				//windows probing logic relies on the word 'windows' in
				//the OS
				boolean isWindows = OS_NAME.indexOf(FAMILY_WINDOWS) > -1;
				boolean is9x = false;
				boolean isNT = false;
				if (isWindows) {
					//there are only four 9x platforms that we look for
					is9x = (OS_NAME.indexOf("95") >= 0 || OS_NAME.indexOf("98") >= 0 || OS_NAME.indexOf("me") >= 0
					//wince isn't really 9x, but crippled enough to
					//be a muchness. Ant doesnt run on CE, anyway.
					|| OS_NAME.indexOf("ce") >= 0);
					isNT = !is9x;
				}
				if (family.equals(FAMILY_WINDOWS)) {
					isFamily = isWindows;
				}
				else if (family.equals(FAMILY_9X)) {
					isFamily = isWindows && is9x;
				}
				else if (family.equals(FAMILY_NT)) {
					isFamily = isWindows && isNT;
				}
				else if (family.equals(FAMILY_OS2)) {
					isFamily = OS_NAME.indexOf(FAMILY_OS2) > -1;
				}
				else if (family.equals(FAMILY_NETWARE)) {
					isFamily = OS_NAME.indexOf(FAMILY_NETWARE) > -1;
				}
				else if (family.equals(FAMILY_DOS)) {
					isFamily = PATH_SEP.equals(";") && !isFamily(FAMILY_NETWARE);
				}
				else if (family.equals(FAMILY_MAC)) {
					isFamily = OS_NAME.indexOf(FAMILY_MAC) > -1;
				}
				else if (family.equals(FAMILY_TANDEM)) {
					isFamily = OS_NAME.indexOf("nonstop_kernel") > -1;
				}
				else if (family.equals(FAMILY_UNIX)) {
					isFamily = PATH_SEP.equals(":") && !isFamily(FAMILY_VMS) && (!isFamily(FAMILY_MAC) || OS_NAME.endsWith("x"));
				}
				else if (family.equals(FAMILY_ZOS)) {
					isFamily = OS_NAME.indexOf(FAMILY_ZOS) > -1 || OS_NAME.indexOf("os/390") > -1;
				}
				else if (family.equals(FAMILY_OS400)) {
					isFamily = OS_NAME.indexOf(FAMILY_OS400) > -1;
				}
				else if (family.equals(FAMILY_VMS)) {
					isFamily = OS_NAME.indexOf(FAMILY_VMS) > -1;
				}
				else {
					throw new IllegalArgumentException("Don\'t know how to detect os family \"" + family + "\"");
				}
			}
			if (name != null) {
				isName = name.equals(OS_NAME);
			}
			if (arch != null) {
				isArch = arch.equals(OS_ARCH);
			}
			if (version != null) {
				isVersion = version.equals(OS_VERSION);
			}
			retValue = isFamily && isName && isArch && isVersion;
		}
		return retValue;
	}

	/**
	 *
	 * @return the default encoding
	 */
	public static final String getDefaultEncoding() {
		return ENCODING;
	}

	/**
	 * 
	 * @param encoding
	 * @return
	 */
	public static final String getEncoding(String encoding) {
		if (StringUtil.isEmpty(encoding)) {
			return ENCODING;
		} else {
			return encoding;
		}
	}

}