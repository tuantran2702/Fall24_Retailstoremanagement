<%-- 
    Document   : Img
    Created on : Oct 30, 2024, 2:00:12 AM
    Author     : ptrung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        padding: 5px 0px;
        border-radius: 5px;
        font-weight: 500;
        align-items: center;
        justify-content: center;
    }

    .Choicefile:hover {
        text-decoration: none;
        color: white;
    }


    #thumbbox {
        position: relative;
        width: 100%;
        margin-bottom: 20px;
    }

    .removeimg {
        height: 25px;
        position: absolute;
        background-repeat: no-repeat;
        top: 5px;
        left: 5px;
        background-size: 25px;
        width: 25px;
        /* border: 3px solid red; */
        border-radius: 50%;

    }

    .removeimg::before {
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        content: '';
        border: 1px solid red;
        background: red;
        text-align: center;
        display: block;
        margin-top: 11px;
        transform: rotate(45deg);
    }

    .removeimg::after {
        /* color: #FFF; */
        /* background-color: #DC403B; */
        content: '';
        background: red;
        border: 1px solid red;
        text-align: center;
        display: block;
        transform: rotate(-45deg);
        margin-top: -2px;
    }
</style>
<div class="form-group col-md-12">
    <label class="control-label">Ảnh 3x4 nhân viên</label>
    <p id="error-message" class="error" style="color: red"></p>
    <div id="myfileupload">
        <input type="file" id="uploadfile" name="ImageUpload" onchange="readURL(this);" style="display: none;" />
    </div>

    <div id="thumbbox">
        <img id="thumbimage" alt="Thumb image" src="<%= ((User) request.getAttribute("user")).getImg() != null ? ((User) request.getAttribute("user")).getImg() : "" %>" 
             style="<%= ((User) request.getAttribute("user")).getImg() != null ? "display: block;" : "display: none;" %>" width="300" height="300"/>
        <a href="javascript:void(0);" class="removeimg" onclick="removeImage()" style="<%= ((User) request.getAttribute("user")).getImg() != null ? "display: block;" : "display: none;" %>"></a>
    </div>

    <div id="boxchoice">
        <a href="javascript:void(0);" class="Choicefile"><i class='bx bx-upload'></i> Chọn file</a>
        <p style="clear:both"></p>
    </div>
</div>

<script>
    // Hàm kiểm tra file hợp lệ
    function validateFile(file) {
        const validImageTypes = ["image/jpeg", "image/png", "image/gif"];
        const maxFileSize = 2 * 1024 * 1024; // 2MB giới hạn kích thước

        // Kiểm tra loại file và kích thước file
        if (!validImageTypes.includes(file.type)) {
            return "Chỉ cho phép file ảnh (JPEG, PNG, GIF).";
        }
        if (file.size > maxFileSize) {
            return "Kích thước ảnh phải nhỏ hơn 2MB.";
        }
        return null;
    }

    // Hàm hiển thị ảnh xem trước và validate file
    $(document).ready(function () {
        $(".Choicefile").click(function () {
            $("#uploadfile").click();
        });

        $(".removeimg").click(removeImage);
    });

    function readURL(input) {
        if (input.files && input.files[0]) {
            const file = input.files[0];
            const error = validateFile(file);

            if (error) {
                $("#error-message").text(error);
                input.value = ""; // Reset input file nếu lỗi
                $("#thumbimage").hide();
                $(".removeimg").hide();
                return;
            }

            const reader = new FileReader();
            reader.onload = function (e) {
                $("#thumbimage").attr('src', e.target.result).show();
                $(".removeimg").show();
                $("#error-message").text(""); // Xóa lỗi
            };
            reader.readAsDataURL(file);
        }
    }

    function removeImage() {
        const defaultImageURL = "/Fall24_Retailstoremanagement/img-anhthe/default.png";
        $("#thumbimage").attr("src", defaultImageURL).show();
        $(".removeimg").hide();
        $("#uploadfile").val("");
        $(".Choicefile").css('background', '#14142B').css('cursor', 'pointer');
    }



</script>