<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	insert.jsp에서 menu 데이터가 여기로 들어오면<br>
	데이터를 DB에 넣기
	<%
		// 메뉴 데이터 전달
		String menu = request.getParameter("menu");
		// 가격 데이터 전달
		String price = request.getParameter("price");
		// 디비 연결 후 insert 하면 되겠네
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
	    
	    String sql = "INSERT INTO `tb_menu` (`menu`, `price`) VALUES (?, ?)";
	    try 
	    {
	        Class.forName(driver);   // 마리아디비 JDBC 라이브러리 부름
	        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
	        if (conn != null) 
	        {
	            System.out.println("DB 접속 성공");
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, menu);
	            pstmt.setString(2, price);
	            
	            int result = pstmt.executeUpdate();	
	            
	            if (result == 1) 
	            {
	                System.out.println("데이터 삽입 성공!");
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
</body>
</html>