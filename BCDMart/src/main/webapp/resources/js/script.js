function checkid() {

	if(regForm.id.value == "") {

		alert("id를 입력하시오.");

		regForm.id.focus();

	} else {

		url = "check_id.jsp?id=" + regForm.id.value;

		// 두 번째 파라미터는 메소드 전송방식이 아니고 타이틀

		window.open(

				url, 

				"id check", "toolbar=no, width=350, height=150, top=150, left=150");

	}
	
}
