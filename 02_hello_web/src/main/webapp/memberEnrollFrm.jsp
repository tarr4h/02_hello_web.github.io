<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>유효성검사</title>
    <style>
    table#enroll{
        border: 1px solid;
        border-spacing:10px;
        width: 500px;
        margin: 0 auto;
    }
    table#enroll th{
        text-align:right;
    }
    table#enroll td.btn-wrapper{
        text-align: center;
    }
    .phone {
        width:30px;
    }
    span.req{
        color:red;
    }
    .short{
        width:50px;
    }
    </style>
</head>
<body>
    <h3>회원가입 유효성검사</h3>
    <p>
        회원가입시 각 필드마다 유효성 검사를 하여 처리 할 수 있도록 만들어라. <br>
        1. ID는 영어소문자,숫자만 가능해야함(4~12자리,소문자로 시작해야함) <br>
        2. 비밀번호는 숫자/문자/특수문자*!& 포함 형태의 8~15자리<br>
        3. 비밀번호와 비밀번호확인은 같아야 함<br>
        4. 이름은 무조건 한글만 가능해야 함(최소2글자 이상)<br>
	5. 주민번호는 자릿수6자리,7자리이고, 모두 숫자여야함.<br>
        6. 이메일은 @가 포함 되어야 함(@앞에가 영문자,숫자로  4~12글자 ) <br>
        7. 전화번호는 첫번째 필드는 010만 입력 가능 해야 함 <br>
                    두번째 필드는 3자리 이상 입력 해야 함 <br>
                    세번째 필드는 무조건 4자리 입력 해야함 <br>
                    (모두 숫자만 가능 해야함) <br>
    </p>
    <!-- request.getContextPath() = /web -->
    <form action="<%= request.getContextPath() %>/member/enroll.do" name="memberFrm" method="POST">
        <table id="enroll">
            <tr>
                <th>아이디<span class="req">*</span></th>
                <td>
                    <input type="text" name="userId" id="userId" >
                </td>
            </tr>
            <tr>
                <th>비밀번호<span class="req">*</span></th>
                <td>
                    <input type="password" name="pwd" id="pwd" >
                </td>
            </tr>
            <tr>
                <th>비밀번호확인</th>
                <td>
                    <input type="password" id="pwdCheck">
                </td>
            </tr>
            <tr>
                <th>이름<span class="req">*</span></th>
                <td>
                    <input type="text" name="userName" id="userName" > 
                </td>
            </tr>
            <tr>
                <th>주민번호<span class="req">*</span></th>
                <td>
                    <input type="text" name="ssn1" id="ssn1" class="short" >-
                    <input type="password" name="ssn2" id="ssn2" class="short" >
                </td>
            </tr>
            <tr>
                <th>이메일<span class="req">*</span></th>
                <td>
                    <input type="email" name="email" id="email" >
                </td>
            </tr>
            <tr>
                <th>전화번호<span class="req">*</span></th>
                <td>
                    <input type="text" name="tel1" id="tel1" class="phone" >-
                    <input type="text" name="tel2" id="tel2" class="phone" >-
                    <input type="text" name="tel3" id="tel3" class="phone" >
                </td>
            </tr>
            <tr>
                <th>직업</th>
                <td>
                    <select name="job" id="job">
                        <option value="공무원">공무원</option>
                        <option value="개발자">개발자</option>
                        <option value="무직">무직</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>취미</th>
                <td>
                    <input type="checkbox" name="hobby" id="hobby1" value="독서">
                    <label for="hobby1">독서</label>
                    <input type="checkbox" name="hobby" id="hobby2" value="개발">
                    <label for="hobby2">개발</label>
                    <input type="checkbox" name="hobby" id="hobby3" value="운동">
                    <label for="hobby3">운동</label>
                    <input type="checkbox" name="hobby" id="hobby4" value="게임">
                    <label for="hobby4">게임</label>
                    <input type="checkbox" name="hobby" id="hobby5" value="영화">
                    <label for="hobby5">영화</label>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="btn-wrapper">
                    <input type="submit" value="제출">&nbsp;
                    <input type="reset" value="초기화">
                </td>
            </tr>
        </table>
    </form>
    <script>
	 document.memberFrm.onsubmit = function(){
		 console.log("[name=hobby]");
        //1.아이디검사
        const checkId = /^[a-z]((?=.*[0-9])(?=.*[a-z]))(?!.*[A-Z])(?!.*[\W]).{3,11}$/;
        console.log(checkId.test(userId.value));
        if(!checkId.test(userId.value)){
            alert("부적합한 입력");
            return false;
        }
        //2.비밀번호 확인 검사 
        const checkPw = /^(?=.*[0-9])(?=.*[a-zA-z])(?=.*[\W]).{8,15}$/;
        console.log(checkPw.test(pwd.value));
        if(!checkPw.test(pwd.value)){
            alert("부적합한 비밀번호");
            return false;
        }
	    //비밀번호일치여부 검사
        if(pwd.value != pwdCheck.value){
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
        //3.이름검사 : 한글2글자 이상만 허용. 
        const checkName = /^[가-힣]{2,}$/;
        if(!checkName.test(userName.value)){
            alert('이름은 한글 2글자 이상 입력하세요');
            return false;
        }
        //4.주민번호체크
        const checkSsn1 = /^\d{2}([0]\d|[1][12])([0][1-9]|[1][0-9]|[2][0-9]|[3][01])$/
        const checkSsn2 = /^[1-4]\d{6}$/;
        if(!checkSsn1.test(ssn1.value) || !checkSsn2.test(ssn2.value)){
            alert('유효하지 않은 주민번호 입니다.');
            return false;
        }
        //5.이메일 검사
        const checkEmail = /\w{4,12}\@[a-z]{4,8}\.(com|co\.kr|net)/;
        if(!checkEmail.test(email.value)){
            alert('유효하지 않은 이메일');
            return false;
        }
        //6. 전화번호 검사
        const checkPh1 = /[0][1]([0]|[1]|[6]|[7]|[9])/;
        const checkPh2 = /\d{3,4}/;
        const checkPh3 = /\d{4}/;
        if(!checkPh1.test(tel1.value) || !checkPh2.test(tel2.value) || !checkPh3.test(tel3.value)){
            alert('유효하지 않은 전화번호');
            return false;
        }
        return true;
    }
    </script>
​
​
</body>
</html>