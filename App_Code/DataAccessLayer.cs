using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// Summary description for DataAccessLayer
/// </summary>
public static class DataAccessLayer
{
	
    public static DataTable GetDataTable(string query)
    {
        string constr = ConfigurationManager.ConnectionStrings["COSConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(constr);
        SqlCommand cmd = new SqlCommand(query, con);
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dt);
        return dt;
    }

    public static DataSet GetDataSet(string query)
    {
        string constr = ConfigurationManager.ConnectionStrings["COSConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(constr);
        SqlCommand cmd = new SqlCommand(query, con);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        return ds;
    }
    public static int GetIdByQuery(string Query)
    {
        string constr = ConfigurationManager.ConnectionStrings["COSConnectionString"].ConnectionString;
        SqlCommand command = new SqlCommand();
        SqlConnection connection = new SqlConnection(constr);
        command = new SqlCommand(Query, connection);

        connection.Open();
        SqlDataAdapter adp = new SqlDataAdapter(command);
        connection.Close();

        DataTable dt = new DataTable();
        adp.Fill(dt);
        connection.Close();

        if (dt.Rows.Count > 0 && dt.Rows[0][0].ToString() != "")
        {
            return int.Parse(dt.Rows[0][0].ToString());
        }

        return 1;

    }

    public static SqlParameter AddParamater(string parameterName, object value, SqlDbType DbType, int size)
    {
        SqlParameter param = new SqlParameter();
        param.ParameterName = parameterName;
        param.Value = value.ToString();
        param.SqlDbType = DbType;
        param.Size = size;
        param.Direction = ParameterDirection.Input;
        return param;
    }

    public static int ExecuteNonQuery(string Query, SqlParameter[] Params)
        {
            string constr = ConfigurationManager.ConnectionStrings["COSConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(Query,conn);
            cmd.Parameters.AddRange(Params);
            
            int NewId=0;
            try
            {
                conn.Open();
                NewId = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();
            }
            catch (Exception ex)
            {
                
            }
            finally
            { 
                
                cmd.Parameters.Clear();
                cmd.Dispose();
                conn.Dispose();
            }
            return NewId;
        }
}
