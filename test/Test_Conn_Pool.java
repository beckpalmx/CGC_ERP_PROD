import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.ConnectionPoolDataSource;
import javax.sql.PooledConnection;

public class Test_Conn_Pool {
  public static void main(String[] args) {
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
      connection = getConnection();
      // Do work with connection
      statement = connection.createStatement();
      String selectEmployeesSQL = " SELECT * FROM memployee ";
      resultSet = statement.executeQuery(selectEmployeesSQL);

      while (resultSet.next()) {
        printEmployee(resultSet);
      }
    } catch (NamingException | SQLException e) {
        System.out.println(e);
    } finally {
      if (resultSet != null) {
        try {
          resultSet.close();
        } catch (SQLException e) {
        } // nothing we can do
      }
      if (statement != null) {
        try {
          statement.close();
        } catch (SQLException e) {
        } // nothing we can do
      }
      if (connection != null) {
        try {
          connection.close();
        } catch (SQLException e) {
        } // nothing we can do
      }
    }
  }

  private static Connection getConnection() throws NamingException, SQLException {
    InitialContext initCtx = createContext();
    String jndiName = "HrDS";
    ConnectionPoolDataSource dataSource = (ConnectionPoolDataSource) initCtx.lookup(jndiName);
    PooledConnection pooledConnection = dataSource.getPooledConnection();
    return pooledConnection.getConnection(); // Obtain connection from pool
  }

  private static InitialContext createContext() throws NamingException {
    Properties env = new Properties();
    env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.rmi.registry.RegistryContextFactory");
    env.put(Context.PROVIDER_URL, "rmi://localhost:1099");
    InitialContext context = new InitialContext(env);
    return context;
  }

  private static void printEmployee(ResultSet resultSet) throws SQLException {
    System.out.print(resultSet.getString("employee_id")+", ");
    System.out.print(resultSet.getString("fname")+", ");
    System.out.print(resultSet.getString("lname")+", ");
    System.out.println(resultSet.getString("status"));
  }

}
