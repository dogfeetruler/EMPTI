package com.hein.empti.saleorders;

import java.util.List;

import com.hein.empti.saleorderdetails.SaleorderdetailsVO;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SorderMasterVO {
	SaleordersVO vo;
	List<SaleorderdetailsVO> list;
}
