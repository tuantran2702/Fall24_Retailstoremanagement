<%-- 
    Document   : Img
    Created on : Oct 27, 2024, 2:30:24 PM
    Author     : ptrung
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<style>
    .Choicefile {
        display: block;
        background: #14142B;
        border: 1px solid #fff;
        color: #fff;
        width: 150px;
        text-align: center;
        text-decoration: none;
        cursor: pointer;
        padding: 5px 0;
        border-radius: 5px;
        font-weight: 500;
        align-items: center;
        justify-content: center;
    }

    .Choicefile:hover {
        text-decoration: none;
        color: white;
    }

    #uploadfile,
    .removeimg {
        display: none;
    }

    #thumbbox {
        position: relative;
        width: 100%;
        margin-bottom: 20px;
    }

    #thumbimage {
        height: 300px;
        width: 300px;
        display: none;
    }

    .removeimg {
        height: 25px;
        position: absolute;
        top: 5px;
        left: 5px;
        background-size: 25px;
        width: 25px;
        border-radius: 50%;
        background-color: red;
    }

    .removeimg::before, .removeimg::after {
        content: '';
        display: block;
        position: absolute;
        top: 50%;
        left: 50%;
        width: 15px;
        height: 2px;
        background-color: white;
    }

    .removeimg::before {
        transform: translate(-50%, -50%) rotate(45deg);
    }

    .removeimg::after {
        transform: translate(-50%, -50%) rotate(-45deg);
    }

    #boxchoice {
        display: flex;
        align-items: center;
    }

</style>

<div class="form-group col-md-12">
    <label class="control-label">Ảnh 3x4 nhân viên</label>
    <p id="error-message" class="error" style="color: red"></p> <!-- Thông báo lỗi -->
    <div id="myfileupload">
        <input type="file" id="uploadfile" name="ImageUpload" onchange="readURL(this);" />
    </div>

    <div id="thumbbox">
        <img height="300" width="300" alt="Thumb image" id="thumbimage" 
             src="<%= ((User) request.getAttribute("user")).getImg() != null ? ((User) request.getAttribute("user")).getImg() : "" %>"
             style="<%= ((User) request.getAttribute("user")).getImg() != null ? "display: block;" : "display: none;" %>"/>
        <a class="removeimg" href="javascript:" onclick="removeImage()"></a>
    </div>

    <div id="boxchoice">
        <a href="javascript:" class="Choicefile"><i class='bx bx-upload'></i> Chọn file</a>
        <p style="clear:both"></p>
    </div>
</div>

<script>
    function validateFile(file) {
        const validImageTypes = ["image/jpeg", "image/png", "image/gif"];
        const maxFileSize = 2 * 1024 * 1024; // 2MB giới hạn kích thước

        if (!validImageTypes.includes(file.type)) {
            return "Chỉ cho phép file ảnh (JPEG, PNG, GIF).";
        }
        if (file.size > maxFileSize) {
            return "Kích thước ảnh phải nhỏ hơn 2MB.";
        }
        return null;
    }

    function readURL(input) {
        if (input.files && input.files[0]) {
            const file = input.files[0];
            const error = validateFile(file);

            if (error) {
                $("#error-message").text(error);
                input.value = "";
                $("#thumbimage").hide();
                $(".removeimg").hide();
                $(".Choicefile").css('background', '#14142B').css('cursor', 'pointer');
                return;
            }

            const reader = new FileReader();
            reader.onload = function (e) {
                $("#thumbimage").attr('src', e.target.result).show();
                $(".removeimg").show();
                $(".Choicefile").css('background', '#14142B').css('cursor', 'default');
            }
            reader.readAsDataURL(file);
            $("#error-message").text("");
        } else {
            $("#thumbimage").attr('src', input.value).show();
        }
    }

    $(document).ready(function () {
        $(".Choicefile").click(function () {
            $("#uploadfile").click();
        });
        $(".removeimg").click(function () {
            $("#thumbimage").attr('src', '').hide();
            $("#uploadfile").val(''); // Reset input file
            $(".removeimg").hide();
            $(".Choicefile").css('background', '#14142B').css('cursor', 'pointer');
            $("#error-message").text("");
        });
    });
</script>

