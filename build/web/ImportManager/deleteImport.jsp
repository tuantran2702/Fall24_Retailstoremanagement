<html>
<head>
    <title>Delete Import</title>
</head>
<body>
    <h2>Are you sure you want to delete this Import?</h2>
    <form action="import" method="post">
        <input type="hidden" name="id" value="<%= request.getAttribute("id") %>" />
        <input type="submit" value="Delete" />
        <input type="hidden" name="action" value="delete" />
    </form>
    <a href="import">Cancel</a>
</body>
</html>
