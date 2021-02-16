package com.hein.empti.common;

import org.apache.commons.collections.map.ListOrderedMap;
import org.springframework.jdbc.support.JdbcUtils;

public class LowerKeyMap extends ListOrderedMap {
	public Object put(Object key, Object value) {
        return super.put(JdbcUtils.convertUnderscoreNameToPropertyName((String) key), value);
    }

}
