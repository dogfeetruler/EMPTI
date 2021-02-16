package com.hein.empti.items.mapper;

import java.util.List;
import java.util.Map;

import com.hein.empti.items.ItemsVO;

public interface ItemsMapper {

	public ItemsVO getItems(ItemsVO itemsVO);
	public List<ItemsVO> getItemsList(ItemsVO itemsVO);
	public void setInsertItems(ItemsVO itemsVO);
	public void setUpdateItems(ItemsVO itemsVO);
	public void setDeleteItems(ItemsVO itemsVO);
	
	//삭제 조건
	public int getDisposalCount(ItemsVO itemsVO);
	public int getBuyDetailCount(ItemsVO itemsVO);
	public int getSaleDetailCount(ItemsVO itemsVO);
	
	//품목 리스트(Map) 엑셀
	public List<Map<String, Object>> getItemsMap(ItemsVO vo);
}
