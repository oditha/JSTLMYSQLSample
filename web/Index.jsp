<%-- 
    Document   : Index
    Created on : Jan 19, 2018, 9:56:23 AM
    Author     : oditha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>



    </head>
    <body>
    <center>
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"

                           url="jdbc:mysql://localhost/requrement3"
                           user="root" password=""

                           />


        <form action="Index.jsp">
            <span>Filter By Salary</span>
            <select name="Salary">

                <option>10000 AND 50000</option>
                <option>25000 AND 50000</option>
                <option>50000 AND 75000</option>
                <option>Upto 75000</option>

            </select>
            <input type="submit" value="Submit" />
        </form>
        <br>


        <sql:query dataSource="${db}" var="rs0">
            SELECT distinct Designation FROM employee;
        </sql:query>

        <form action="Index.jsp">
            <span>Filter By Designation</span>
            <select name="Desi">
                <c:forEach var="table0" items="${rs0.rows}">

                    <option><c:out value="${table0.Designation}"/></option>

                </c:forEach>

            </select>
            <input type="submit" value="Submit" />
        </form>
        <c:choose>

            <c:when test="${(empty param.Desi) && (empty param.Salary)}">
                <sql:query dataSource="${db}" var="rs">

                    SELECT * FROM employee;

                </sql:query> 
            </c:when>

            <c:otherwise>

                <c:if test="${empty param.Salary}">
                    <sql:query dataSource="${db}" var="rs">

                        SELECT * FROM employee WHERE Designation = '<c:out value = "${param.Desi}"/>';

                    </sql:query> 

                </c:if>
                <c:if test="${empty param.Desi}">
                    <c:choose>

                        <c:when test="${param.Salary == 'Upto 75000'}">
                            <sql:query dataSource="${db}" var="rs">

                                SELECT * FROM employee WHERE Salary > '75000';

                            </sql:query> 

                        </c:when>
                        <c:otherwise>
                            <c:set var="sala" value="${param.Salary}"/>
                            <c:set var="salary" value="${fn:split(sala, ' AND ')}"/>
                            <sql:query dataSource="${db}" var="rs">

                                SELECT * FROM employee WHERE Salary BETWEEN '${salary[0]}' AND '${salary[1]}';

                            </sql:query> 
                        </c:otherwise>

                    </c:choose>

                </c:if>

            </c:otherwise>
        </c:choose>


        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Degisnation</th>
                    <th>Salary</th>
                </tr>
            </thead>
            <tbody>

                <c:forEach var="table" items="${rs.rows}">

                    <tr>
                        <td><c:out value="${table.id}"/></td>
                        <td><c:out value="${table.Name}"/></td>
                        <td><c:out value="${table.Designation}"/></td>
                        <td><c:out value="${table.Salary}"/></td>
                    </tr>


                </c:forEach>

            </tbody>
        </table>

    </center>
</body>
</html>
