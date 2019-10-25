using ClosedXML.Excel;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Projeto
{
    public partial class Projeto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.BindGrid();
            }
        }

        private void BindGrid()
        {
            Connection connect = new Connection();
            MySqlConnection con = connect.conectar();
            using (MySqlCommand cmd = new MySqlCommand("SELECT * FROM usuario"))
            {
                using (MySqlDataAdapter sda = new MySqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
        }

        protected void Insert(object sender, EventArgs e)
        {
            Label lblErro = (Label)form1.FindControl("txtErro");
            string nome = txtNome.Text;
            string endereco = txtEndereco.Text;
            string email = txtEmail.Text;
            string clogin = txtCLogin.Text;
            string csenha = txtCSenha.Text;

            try
            {
                Connection connect = new Connection();
                MySqlConnection con = connect.conectar();

                using (MySqlCommand cmd = new MySqlCommand("INSERT INTO usuario (nm_nome, nm_endereco, nm_email, nm_login, nm_senha) VALUES (@Nome, @Endereco, @Email, @Login, @Senha)"))
                {
                    using (MySqlDataAdapter sda = new MySqlDataAdapter())
                    {
                        cmd.Parameters.AddWithValue("@Nome", nome);
                        cmd.Parameters.AddWithValue("@Endereco", endereco);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Login", clogin);
                        cmd.Parameters.AddWithValue("@Senha", csenha);
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErro.Text = "";
                    }
                }

            }
            catch (MySqlException erro)
            {
                if (erro.Number == 1062)
                {
                    lblErro.Text = "Login ja em uso";
                }
            }
            this.BindGrid();
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            this.BindGrid();
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string nome = (row.FindControl("txtNome") as TextBox).Text;
            string endereco = (row.FindControl("txtEndereco") as TextBox).Text;
            string email = (row.FindControl("txtEmail") as TextBox).Text;
            string login = (row.FindControl("txtLogin") as TextBox).Text;
            string senha = (row.FindControl("txtSenha") as TextBox).Text;
            Connection connect = new Connection();
            MySqlConnection con = connect.conectar();
            using (MySqlCommand cmd = new MySqlCommand("UPDATE usuario SET nm_nome = @Nome, nm_endereco = @Endereco, nm_email = @Email, nm_login = @Login, nm_senha = @Senha WHERE cd_id = @Id"))
            {
                using (MySqlDataAdapter sda = new MySqlDataAdapter())
                {
                    cmd.Parameters.AddWithValue("@Nome", nome);
                    cmd.Parameters.AddWithValue("@Endereco", endereco);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Login", login);
                    cmd.Parameters.AddWithValue("@Senha", senha);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int Id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            Connection connect = new Connection();
            MySqlConnection con = connect.conectar();
            using (MySqlCommand cmd = new MySqlCommand("DELETE FROM usuario WHERE cd_id = @Id"))
            {
                using (MySqlDataAdapter sda = new MySqlDataAdapter())
                {
                    cmd.Parameters.AddWithValue("@Id", Id);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

            }
            this.BindGrid();
        }

        protected void Procurar(object sender, EventArgs e)
        {
            var procurar = txtProcurar.Text;
            Connection connect = new Connection();
            MySqlConnection con = connect.conectar();
            using (MySqlCommand cmd = new MySqlCommand("SELECT * FROM usuario WHERE nm_nome = @Procurar"))
            {
                using (MySqlDataAdapter sda = new MySqlDataAdapter())
                {
                    cmd.Parameters.AddWithValue("@Procurar", procurar);
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }

                }
            }
        }

        protected void Logar(object sender, EventArgs e)
        {
            Label lblStatus = (Label)form1.FindControl("txtStatus");
            Label lblErro = (Label)form1.FindControl("txtErro");
            var login = txtLogin.Text;
            var senha = txtSenha.Text;
            Connection connect = new Connection();
            MySqlConnection con = connect.conectar();

            using (MySqlCommand cmd = new MySqlCommand("SELECT nm_nome, nm_senha, nm_login FROM usuario WHERE nm_login = @Login"))
            {
                using (MySqlDataAdapter sda = new MySqlDataAdapter())
                {
                    cmd.Parameters.AddWithValue("@Senha", senha);
                    cmd.Parameters.AddWithValue("@Login", login);
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;

                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {

                            foreach (DataRow row in dt.Rows)
                            {
                                if (senha.Equals(row["nm_senha"].ToString()) && login.Equals(row["nm_login"].ToString()))
                                {
                                    Session["Nome"] = row["nm_nome"];
                                    lblStatus.Text = "Logado, Bem vindo " + Session["Nome"].ToString();
                                }
                                else
                                {
                                    lblErro.Text = "Login ou senha invalidos";
                                }
                            }
                        }
                        else
                        {
                            lblErro.Text = "Usuario inexsistente";
                        }


                    }
                }
            }
        }

        protected void mostrar_Click(object sender, EventArgs e)
        {
            this.BindGrid();
        }

        protected void Sair(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Projeto.aspx");
        }

        protected void Exportar(object sender, EventArgs e)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                Connection connect = new Connection();
                MySqlConnection con = connect.conectar();
                using (MySqlCommand cmd = new MySqlCommand("SELECT * FROM usuario"))
                {
                    using (MySqlDataAdapter sda = new MySqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            //Add DataTable as Worksheet.
                            wb.Worksheets.Add(dt, "GridView.xlsx");
                            Exportar ex = new Exportar();

                            ex.Export(dt, wb);

                        }
                    }
                }


            }
        }
    }
}