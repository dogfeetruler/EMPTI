package com.hein.empti.items.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hein.empti.items.ItemsVO;
import com.hein.empti.items.mapper.ItemsMapper;
import com.hein.empti.items.service.ItemsService;

@Service
public class ItemsServiceImpl implements ItemsService {

	@Autowired
	ItemsMapper itemsMapper;
	
	@Override
	public ItemsVO getItems(ItemsVO itemsVO) {
		return itemsMapper.getItems(itemsVO);
	}

	@Override
	public List<ItemsVO> getItemsList(ItemsVO itemsVO) {
		return itemsMapper.getItemsList(itemsVO);
	}

	@Override
	public void setInsertItems(ItemsVO itemsVO) {
		itemsMapper.setInsertItems(itemsVO);
	}

	@Override
	public void setUpdateItems(ItemsVO itemsVO) {
		itemsMapper.setUpdateItems(itemsVO);
	}


	@Override
	public List<Map<String, Object>> getItemsMap(ItemsVO vo) {
		return itemsMapper.getItemsMap(vo);
	}

	//삭제
	@Override
	public void setDeleteItems(ItemsVO itemsVO) {
		itemsMapper.setDeleteItems(itemsVO);
	}

	//삭제 조건
	@Override
	public int getDisposalCount(ItemsVO itemsVO) {
		return itemsMapper.getDisposalCount(itemsVO);
	}

	@Override
	public int getBuyDetailCount(ItemsVO itemsVO) {
		return itemsMapper.getBuyDetailCount(itemsVO);
	}

	@Override
	public int getSaleDetailCount(ItemsVO itemsVO) {
		return itemsMapper.getSaleDetailCount(itemsVO);
	}
	
	

}
