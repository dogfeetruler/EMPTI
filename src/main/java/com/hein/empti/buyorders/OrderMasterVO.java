package com.hein.empti.buyorders;

import java.util.List;

import com.hein.empti.buyorderdetails.BuyorderdetailsVO;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderMasterVO {
	BuyordersVO vo;
	List<BuyorderdetailsVO> list;
}
