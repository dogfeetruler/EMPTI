package com.hein.empti.common;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

@Component("commonExcelView")
public class CommonExcelView extends AbstractXlsxView {

	private static final Logger LOGGER = LoggerFactory.getLogger(CommonExcelView.class);

	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// 파일 네임 변경해주는 코드
		String file_name = (String) model.get("filename") + System.currentTimeMillis() + ".xlsx";
		response.setHeader("Content-Disposition", "attachment; filename=\"" + file_name + "\"");

		Cell cell = null;
		Sheet sheet = workbook.createSheet("User List");
		sheet.setDefaultColumnWidth(12);
		List<Map<String, Object>> list = (List<Map<String, Object>>) model.get("datas");
		Row row;

		// 셀 스타일 설정
		CellStyle mergeRowStyle1 = workbook.createCellStyle();
		CellStyle header1 = workbook.createCellStyle();
		// CellStyle header1 = workbook.createCellStyle();

		// 열 폭 지정
		sheet.setColumnWidth(0, 5000);
		sheet.setColumnWidth(1, 5000);
		sheet.setColumnWidth(2, 5000);
		sheet.setColumnWidth(3, 5000);
		sheet.setColumnWidth(4, 5000);
		sheet.setColumnWidth(5, 5000);
		sheet.setColumnWidth(6, 5000);
		sheet.setColumnWidth(7, 5000);
		sheet.setColumnWidth(8, 5000);
		sheet.setColumnWidth(9, 5000);
		sheet.setColumnWidth(10, 5000);

		// 정렬
		mergeRowStyle1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		header1.setAlignment(HSSFCellStyle.ALIGN_CENTER);

		// 테두리
		mergeRowStyle1.setBorderTop(CellStyle.BORDER_DASH_DOT_DOT); // 넣는 형식 : CellStyle.BORDER_DASH_DOT
		mergeRowStyle1.setBorderLeft(CellStyle.BORDER_DASH_DOT_DOT);
		mergeRowStyle1.setBorderRight(CellStyle.BORDER_DASH_DOT_DOT);
		mergeRowStyle1.setBorderBottom(CellStyle.BORDER_DASH_DOT_DOT);

		header1.setBorderBottom(CellStyle.BORDER_THICK);
		header1.setBorderTop(CellStyle.BORDER_THICK);
		header1.setBorderLeft(CellStyle.BORDER_THICK);
		header1.setBorderRight(CellStyle.BORDER_THICK);

		// 배경색
		header1.setFillPattern(CellStyle.SOLID_FOREGROUND);
		header1.setFillBackgroundColor(HSSFColor.LIGHT_BLUE.index);
		header1.setFillForegroundColor(HSSFColor.LIME.index);

		// 폰트
		Font headerFont = workbook.createFont();
		headerFont.setFontName("나눔고딕");
		headerFont.setFontHeight((short) 200);
		headerFont.setColor(IndexedColors.DARK_GREEN.getIndex());
		headerFont.setBold(true);

		
		
		mergeRowStyle1.setFont(headerFont);

		// Header 출력
		int rowNum = 0;
		String[] headers = (String[]) model.get("headers");
		if (headers != null) {
			row = sheet.createRow(rowNum++);
			int colNum = 0;
			for (String header : headers) {
				cell = row.createCell(colNum++);
				cell.setCellValue(header); // 해더 값 적용 받는 부분
				cell.setCellStyle(header1); // 해더 스타일 적용
			}
		}

		if (headers != null) {
			for (int i = 0; i < list.size(); i++) {
				row = sheet.createRow(i + 1); // 해더 칸을 위해 반복은 1부터 반복
				Map map = list.get(i);
				int j = 0;
				for (String header : headers) {
					cell = row.createCell(j++);
					cell.setCellStyle(mergeRowStyle1); // 셀 스타일 적용
					if (map.get(header) != null) {
						cell.setCellValue(map.get(header).toString()); // toString -->null 에러때문에 if 문으로 돌려서 else에 빈공간으로
																		// 남겨둠 -->그럼 에러 없음
					} else {
					}
				}
			}

		}

		else {
			for (int i = 0; i < list.size(); i++) {
				row = sheet.createRow(i);
				Map map = list.get(i);
				Iterator<String> iter = map.keySet().iterator();
				int j = 0;
				while (iter.hasNext()) {
					cell = (HSSFCell) row.createCell(j++);
					cell.setCellStyle(mergeRowStyle1); // 셀 스타일 적용
					cell.setCellValue(map.get(iter.next()).toString());
				}
			}
		}

	}

	private Cell CellStyle() {
		// TODO Auto-generated method stub
		return null;
	}
}