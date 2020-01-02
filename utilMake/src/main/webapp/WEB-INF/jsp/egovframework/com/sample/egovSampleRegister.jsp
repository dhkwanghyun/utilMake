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
    <%@ include file="/WEB-INF/jsp/egovframework/com/cmmn/include/include-header.jspf" %>
    <c:set var="registerFlag" value="${empty sampleVO.id ? 'create' : 'modify'}"/>
    <title>Sample <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                  <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
    </title>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
    <validator:javascript formName="sampleVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">

        /* 글 목록 화면 function */
        function fn_egov_selectList() {
           	document.detailForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 삭제 function */
        function fn_egov_delete() {
           	document.detailForm.action = "<c:url value='/deleteSample.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 등록 function */
        function fn_egov_save() {
        	frm = document.detailForm;
        	if(!validateSampleVO(frm)){
                return;
            }else{
            	frm.action = "<c:url value="${registerFlag == 'create' ? '/addSample.do' : '/updateSample.do'}"/>";
                frm.submit();
            }
        }

    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<form:form commandName="sampleVO" id="detailForm" name="detailForm" enctype="multipart/form-data" method="post">
    <div id="content_pop">
    	<!-- 타이틀 -->
    	<div id="title">
    		<ul>
    			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
                    <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                    <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
                </li>
    		</ul>
    	</div>
    	<!-- // 타이틀 -->
    	<div id="table">
    	<table width="100%" border="1" cellpadding="0" cellspacing="0" style="bordercolor:#D3E2EC; bordercolordark:#FFFFFF; BORDER-TOP:#C2D0DB 2px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT:#ffffff 1px solid; BORDER-BOTTOM:#C2D0DB 1px solid; border-collapse: collapse;">
    		<colgroup>
    			<col width="150"/>
    			<col width="?"/>
    		</colgroup>
    		<c:if test="${registerFlag == 'modify'}">
        		<tr>
        			<td class="tbtd_caption"><label for="id"><spring:message code="title.sample.id" /></label></td>
        			<td class="tbtd_content">
        				<form:input path="id" cssClass="essentiality" maxlength="10" readonly="true" />
        			</td>
        		</tr>
    		</c:if>
    		<tr>
    			<td class="tbtd_caption"><label for="name"><spring:message code="title.sample.name" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="name" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="name" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="useYn"><spring:message code="title.sample.useYn" /></label></td>
    			<td class="tbtd_content">
    				<form:select path="useYn" cssClass="use">
    					<form:option value="Y" label="Yes" />
    					<form:option value="N" label="No" />
    				</form:select>
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="description"><spring:message code="title.sample.description" /></label></td>
    			<td class="tbtd_content">
    				<form:textarea path="description" rows="5" cols="58" />&nbsp;<form:errors path="description" />
                </td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="regUser"><spring:message code="title.sample.regUser" /></label></td>
    			<td class="tbtd_content">
                    <c:if test="${registerFlag == 'modify'}">
        				<form:input path="regUser" maxlength="10" cssClass="essentiality" readonly="true" />
        				&nbsp;<form:errors path="regUser" /></td>
                    </c:if>
                    <c:if test="${registerFlag != 'modify'}">
        				<form:input path="regUser" maxlength="10" cssClass="txt"  />
        				&nbsp;<form:errors path="regUser" /></td>
                    </c:if>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="regUser">파일업로드</label></td>
    			<td class="tbtd_content">
                    <c:if test="${registerFlag == 'modify'}">
                    	<c:forEach var="row" items="${list }">
						<p>
							<input type="hidden" id="fileSeq" value="${row.fileSeq }">
							<a href="#this" name="file">${row.originalFileName }</a> 
							(${row.fileSize }kb)
						</p>
						</c:forEach>
                    </c:if>
                    <c:if test="${registerFlag != 'modify'}">
				      <div id="fileDiv">
						<p>
							<input type="file" id="file" name="file_0">
							<a href="#this" class="btn" id="delete" name="delete">삭제</a>
						</p>
					  </div>
					  <br/><br/>
					  <a href="#this" class="btn" id="addFile">파일 추가</a>
                    </c:if>
                </td>
    		</tr>
    	</table>
      </div>
    	<div id="sysbtn">
    		<ul>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_selectList();"><spring:message code="button.list" /></a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_save();">
                            <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                            <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
                        </a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
    			<c:if test="${registerFlag == 'modify'}">
                    <li>
                        <span class="btn_blue_l">
                            <a href="javascript:fn_egov_delete();"><spring:message code="button.delete" /></a>
                            <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                        </span>
                    </li>
    			</c:if>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:document.detailForm.reset();"><spring:message code="button.reset" /></a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
            </ul>
    	</div>
    </div>
    <!-- 검색조건 유지 -->
    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
<%@ include file="/WEB-INF/jsp/egovframework/com/cmmn/include/include-body.jspf" %>
<script type="text/javascript">
	var gfv_count = 1;

	$(document).ready(function(){
		
		$("#addFile").on("click", function(e){ //파일 추가 버튼
			e.preventDefault();
			fn_addFile();
		});
		
		$("a[name='delete']").on("click", function(e){ //삭제 버튼
			e.preventDefault();
			fn_deleteFile($(this));
		});
		
		$("a[name='file']").on("click", function(e){ //파일 이름
			e.preventDefault();
			fn_downloadFile($(this));
		});
		
	});
	
	function fn_addFile(){
		var str = "<p><input type='file' name='file_"+(gfv_count++)+"'><a href='#this' class='btn' name='delete'>삭제</a></p>";
		$("#fileDiv").append(str);
		$("a[name='delete']").on("click", function(e){ //삭제 버튼
			e.preventDefault();
			fn_deleteFile($(this));
		});
	}
	
	function fn_deleteFile(obj){
		obj.parent().remove();
	}
	
	function fn_downloadFile(obj){
		var fileSeq = obj.parent().find("#fileSeq").val();
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/common/downloadFile.do' />");
		comSubmit.addParam("fileSeq", fileSeq);
		comSubmit.submit();
	}
</script>


</body>
</html>