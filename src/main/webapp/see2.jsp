<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container">
  <h2>메뉴 보기</h2>            
  <table class="table table-hover">
    <thead>
      <tr>
        <th>메뉴</th>
        <th>가격</th>
        <th>수정</th>
        <th>삭제</th>
        
      </tr>
    </thead>
    <tbody>
   	<%
		final String driver = "org.mariadb.jdbc.Driver";
		final String DB_IP = "localhost";
		final String DB_PORT = "3307";
		final String DB_NAME = "mydb";
		final String DB_USER = "root";
		final String DB_PASS = "1234";
		final String DB_URL = "jdbc:mariadb://" + DB_IP + ":" + DB_PORT + "/" + DB_NAME;
		Connection conn = null;   // 디비연결
		PreparedStatement pstmt = null;  // 쿼리 생성
		ResultSet rs = null;   // select하고 나서 나오는 결과값
		
		String sql = "SELECT * FROM tb_menu";
		try 
		{
		    Class.forName(driver);   // 마리아디비 JDBC 라이브러리 부름
		    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
		    if (conn != null) 
		    {
		        System.out.println("DB 접속 성공");
		        pstmt = conn.prepareStatement(sql);
		        rs = pstmt.executeQuery();
		        while (rs.next()) 
		        {
		            String menu = rs.getString("menu");
		            int price = rs.getInt("price");
   	%>
    <tr>
      <td><%=menu %></td>
      <td><%=price %></td>
      <td><a href="soojung.jsp">수정</a></td>
      <td><a href="del.jsp">삭제</a></td>
    </tr>
	<%
				}
		    }
		} 
		catch (ClassNotFoundException e) 
		{
		    System.out.println("드라이버 로드 실패");
		    e.printStackTrace();
		} 
		catch (Exception e) 
		{
			System.out.println("데이터 삽입 실패!");
		    e.printStackTrace();
		} 
		finally 
		{
		    try 
		    {
		    	if (rs != null) 
		    	{
		            rs.close();
		        }
		        if (pstmt != null && !pstmt.isClosed())
		        {
		            pstmt.close();
		        }
		        if (conn != null && !conn.isClosed())
		        {
		            conn.close();
		        }
		    } 
		    catch (Exception e2) 
		    {
		        e2.printStackTrace();
		    }
		}	
	%>      
    </tbody>
  </table>
</div>

</body>
</html>