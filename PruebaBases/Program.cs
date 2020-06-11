using MongoDB.Driver.Core.Configuration;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PruebaBases
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                var dataSet = new DataSet();
                Console.Write("1. Reporte \n2. RegresaN \n3. RegresaAgendaHoy \n4. InsertarComentarioNomina \n" +
                    "5. InsertarComentario \n6. BorrarComentario \n7. ActualizaRubro \n");
                Console.Write("Ingrese el numero de la opcion: ");
                int Option = Convert.ToInt32(Console.ReadLine());


                string conn = @"Server=localhost\SQLExpress;Database=Evaluaciones-Ventura;Trusted_Connection=True;";

                switch (Option)
                {

                    case 1:
                        using (SqlConnection connection = new SqlConnection(conn))
                        {
                            connection.Open();
                            Console.WriteLine("Connection Done.");


                            using (SqlCommand command = new SqlCommand("[dbo].[Reporte]", connection))
                            {
                                command.CommandType = System.Data.CommandType.StoredProcedure;
                                command.Parameters.AddWithValue("@Rango1fecha", "2020-06-03 21:53:00");
                                command.Parameters.AddWithValue("@Rango2fecha", "2020-06-03 21:59:00");



                                command.ExecuteNonQuery();
                                Console.WriteLine("Lista escritura con un SP.");


                                var dataAdapter = new SqlDataAdapter { SelectCommand = command };

                                dataAdapter.Fill(dataSet);

                                for (int i = 0; i < dataSet.Tables[0].Rows.Count; i++)
                                {
                                    Console.WriteLine("\n");
                                    Console.Write(dataSet.Tables[0].Rows[i]["Nomina"].ToString());
                                    Console.WriteLine("");
                                    Console.Write(dataSet.Tables[0].Rows[i]["Nombres"].ToString());
                                    Console.WriteLine("\n");
                                }
                            }

                            connection.Close();
                        }
                        break;
                    case 2:
                        //'Geronimo', 'Duplicado', '2020-05-10 00:00:00'
                        using (SqlConnection connection = new SqlConnection(conn))
                        {
                            connection.Open();
                            Console.WriteLine("Connection Done.");


                            using (SqlCommand command = new SqlCommand("[dbo].[RegresaN]", connection))
                            { 
                                command.CommandType = System.Data.CommandType.StoredProcedure;
                                command.Parameters.AddWithValue("@Nombre", "Geronimo");
                                command.Parameters.AddWithValue("@Apellido", "Duplicado");
                                command.Parameters.AddWithValue("@Fecha", "2020-06-10 21:59:00");



                                command.ExecuteNonQuery();
                                Console.WriteLine("Lista escritura con un SP.");


                                var dataAdapter = new SqlDataAdapter { SelectCommand = command };

                                dataAdapter.Fill(dataSet);

                                for (int i = 0; i < dataSet.Tables[0].Rows.Count; i++)
                                {
                                    Console.WriteLine("\n");
                                    Console.Write(dataSet.Tables[0].Rows[i]["Nomina"].ToString());
                                    Console.WriteLine("");
                                    Console.Write(dataSet.Tables[0].Rows[i]["Nombres"].ToString());
                                    Console.WriteLine("");
                                    Console.Write(dataSet.Tables[0].Rows[i]["Apellidos"].ToString());
                                    Console.WriteLine("\n");
                                }
                            }

                            connection.Close();
                        }
                        break;
                    case 3:
                        //@Dias INT
                        using (SqlConnection connection = new SqlConnection(conn))
                        {
                            connection.Open();
                            Console.WriteLine("Connection Done.");


                            using (SqlCommand command = new SqlCommand("[dbo].[RegresaAgendaHoy]", connection))
                            {
                                command.CommandType = System.Data.CommandType.StoredProcedure;
                                command.Parameters.AddWithValue("@Dias", "1");


                                command.ExecuteNonQuery();
                                Console.WriteLine("Lista escritura con un SP.");

                                var dataAdapter = new SqlDataAdapter { SelectCommand = command };

                                dataAdapter.Fill(dataSet);

                                for (int i = 0; i < dataSet.Tables[0].Rows.Count; i++)
                                {
                                    Console.WriteLine("\n");
                                    Console.Write(dataSet.Tables[0].Rows[i]["Nomina"].ToString());
                                    Console.WriteLine("");
                                    Console.Write(dataSet.Tables[0].Rows[i]["Nombres"].ToString());
                                    Console.WriteLine("");
                                    Console.Write(dataSet.Tables[0].Rows[i]["Apellidos"].ToString());
                                    Console.WriteLine("\n");
                                }
                            }

                            connection.Close();
                        }
                        break;
                    case 4:
                        //'L00842300', 'Ahora sí, por que se llaman igual'
                        using (SqlConnection connection = new SqlConnection(conn))
                        {
                            connection.Open();
                            Console.WriteLine("Connection Done.");


                            using (SqlCommand command = new SqlCommand("[dbo].[InsertarComentarioNomina]", connection))
                            {
                                command.CommandType = System.Data.CommandType.StoredProcedure;
                                command.Parameters.AddWithValue("@Nomina", "L00842300");
                                command.Parameters.AddWithValue("@ComentarioProf", "Ahora sí, por que se llaman igual");


                                command.ExecuteNonQuery();
                                Console.WriteLine("Lista escritura con un SP.");

                                Console.WriteLine("La tabla ha sido modificada");
                                
                            }

                            connection.Close();
                        }
                        break;

                    case 5:
                        //'Geronimo', 'Duplicado', 'Por que se llaman igual?'
                        using (SqlConnection connection = new SqlConnection(conn))
                        {
                            connection.Open();
                            Console.WriteLine("Connection Done.");


                            using (SqlCommand command = new SqlCommand("[dbo].[InsertarComentario]", connection))
                            {
                                command.CommandType = System.Data.CommandType.StoredProcedure;
                                command.Parameters.AddWithValue("@NombreProf", "Geronimo");
                                command.Parameters.AddWithValue("@ApellidoProf", "Duplicado");
                                command.Parameters.AddWithValue("@ComentarioProf", "Por que se llaman igual?");


                                command.ExecuteNonQuery();
                                Console.WriteLine("Lista escritura con un SP.");

                                Console.WriteLine("La tabla ha sido modificada");
                            }

                            connection.Close();
                        }
                        break;
                    case 6:
                        //'L01568170', '2020-06-03 21:59:00'
                        using (SqlConnection connection = new SqlConnection(conn))
                        {
                            connection.Open();
                            Console.WriteLine("Connection Done.");


                            using (SqlCommand command = new SqlCommand("[dbo].[BorraComentario]", connection))
                            {
                                command.CommandType = System.Data.CommandType.StoredProcedure;
                                command.Parameters.AddWithValue("@Nomina", "L01568072");
                                command.Parameters.AddWithValue("@Fecha", "2020-06-03 21:53:00");
            


                                command.ExecuteNonQuery();
                                Console.WriteLine("Lista escritura con un SP.");

                                Console.WriteLine("La tabla ha sido modificada");
                            }

                            connection.Close();
                        }
                        break;

                    case 7:
                        // 2, 'L01568072', 30
                         using (SqlConnection connection = new SqlConnection(conn))
                        {
                            connection.Open();
                            Console.WriteLine("Connection Done.");


                            using (SqlCommand command = new SqlCommand("[dbo].[ActualizaRubro]", connection))
                            {
                                command.CommandType = System.Data.CommandType.StoredProcedure;
                                command.Parameters.AddWithValue("@Columna", "2");
                                command.Parameters.AddWithValue("@Nomina", "L01568072");
                                command.Parameters.AddWithValue("@NuevaCalif", "50");



                                command.ExecuteNonQuery();
                                Console.WriteLine("Lista escritura con un SP.");

                                Console.WriteLine("La tabla ha sido modificada");
                            }

                            connection.Close();
                        }
                        break;
                }

               

            }
            catch (SqlException e)
            {
                Console.WriteLine(e.ToString());
            }
        }
    }
}
