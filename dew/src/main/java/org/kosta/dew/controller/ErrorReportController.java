package org.kosta.dew.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.kosta.dew.model.service.ErrorReportService;
import org.kosta.dew.model.vo.ErrorReportVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorReportController {
	@Resource
	private ErrorReportService errorReportService;

	@RequestMapping("report_writeForm.do")
	public String reportWriteView(){
		return "errorReport_writeForm";
	}
	
	@RequestMapping("report_updateView.do")
	public ModelAndView reportUpdateView(String errorNo,String type){
		System.out.println("report_updateView.do start \n errorNo :" + errorNo);
		ModelAndView mav = new ModelAndView("errorReport_updateForm");
		mav.addObject("evo", errorReportService.getContent(Integer.parseInt(errorNo)));
		mav.addObject("type",type);
		//System.out.println("report_updateView : evo >"+   );
		return mav;
	}
	
	@RequestMapping("report_listView.do")
	public ModelAndView reportView(){
		List<ErrorReportVO> list = null;
		ModelAndView mav = new ModelAndView("errorReport_listView");
		mav.addObject("errorcode", errorReportService.getReportErrorCode());
		mav.addObject("exception",errorReportService.getReportExceptionMessage());
		return mav;
	}
	
	@RequestMapping("report_showContent.do")
	public ModelAndView reportShowContent(String error,String type){
		ModelAndView mav = new ModelAndView("errorReport_showContent");
		ErrorReportVO vo = errorReportService.getContent(error,type);
		if(type.equals("exception")){
			mav.addObject("exception", vo);	
			mav.addObject("type","ExceptionMessage");
		}else{
			mav.addObject("errorcode",vo);
			mav.addObject("type","ErrorCode");
		}
		return mav;
	}
	
	@RequestMapping("report_write.do")
	public ModelAndView reportWrite(HttpSession session,ErrorReportVO vo, String type,String title){
		int errorNo = errorReportService.reportWrite(vo,type,title);
		System.out.println("vo : " + vo  + " type : " + type + " title : " + title);
		ModelAndView mav = new ModelAndView("redirect:/report_write_result.do?errorNo="+ errorNo);
		return mav;
	}
	
	@RequestMapping("report_write_result.do")
	public ModelAndView reportWriteResult(int errorNo){
		ModelAndView mav = new ModelAndView("errorReport_writeResult");
		mav.addObject("result",errorReportService.getContent(errorNo));
		return mav;
	}
	
	@RequestMapping("report_update.do")
	public String reportUpdate(ErrorReportVO vo, String type,String title){
		int errorNo = errorReportService.reportWrite(vo,type,title);
		return "redirect:/report_write_result.do?errorNo="+errorNo;
	}
}
