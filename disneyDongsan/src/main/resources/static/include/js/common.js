// 빈칸 유효성 검사
// 함수명: chkData(유효성 체크 대상, 메시지 내용)
function chkData(item, msg) {
	if ($(item).val().replace(/\s/g, "") == "") {
		alert(msg + " 입력해주세요.");
		$(item).val("");
		$(item).focus();
		return false;
	} else {
		return true;
	}
};

function formCheck(item, msgArea, msg){
	if ($(item).val().replace(/\s/g, "") == "") {
		$(msgArea).text(msg + " 입력해주세요.").css("color","red");
		$(item).val("");
		$(item).focus();
		return false;
	} else {
		return true;
	}
};