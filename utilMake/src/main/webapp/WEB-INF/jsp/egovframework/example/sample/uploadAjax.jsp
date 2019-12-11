<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : egovSampleRegister.jsp
  * @Description : Sample Register 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">

<head>
    <%@ include file="/WEB-INF/jsp/egovframework/example/cmmn/include/include-header.jspf" %>
    <c:set var="registerFlag" value="${empty sampleVO.id ? 'create' : 'modify'}"/>
    <title>Sample <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                  <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
    </title>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
    <validator:javascript formName="sampleVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">
		$(document).ready(function(){
			$(".fileDrop").on("dragenter dragover",function(event){
				event.preventDefault();
			});
			
			$(".fileDrop").on("drop",function(event){
				event.preventDefault();
			});
			
			$(".fileDrop").on("drop",function(event){
				event.preventDefault();
				var files = event.originalEvent.dataTransfer.files;
				var file = files[0];
				
				var formData = new FormData();
				formData.append("file",file);
				
				$.ajax({
					url:"<c:url value='/uploadAjax.ajax'/>",
					data:formData,
					dataType:'text',
					processData:false,
					contentType:false,
					type:'POST',
					success: function(data){
						console.log(data);
					}
				});
			})
			
		});
    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
	<h3>Ajax File Upload</h3>
	<div class="fileDrop"></div>
	<div class='uploadedList'></div>
</body>
</html>