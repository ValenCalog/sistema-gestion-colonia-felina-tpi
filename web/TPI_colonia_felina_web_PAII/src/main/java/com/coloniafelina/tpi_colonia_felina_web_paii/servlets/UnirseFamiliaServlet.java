
import com.prog.tpi_colonia_felina_paii.controlador.ControladorRegistroUsuarios;
import com.prog.tpi_colonia_felina_paii.dao.FamiliaDAOImpl;
import com.prog.tpi_colonia_felina_paii.dao.UsuarioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.dao.VeterinarioDAOJPAImpl;
import com.prog.tpi_colonia_felina_paii.modelo.Familia;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UnirseFamiliaServlet", urlPatterns = {"/UnirseFamiliaServlet"})
public class UnirseFamiliaServlet extends HttpServlet {

    // Usamos el DAO de Familia para buscar el código
    private final ControladorRegistroUsuarios controlador = new ControladorRegistroUsuarios(new UsuarioDAOJPAImpl(), new VeterinarioDAOJPAImpl(), new FamiliaDAOImpl());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigo = request.getParameter("codigoFamilia");

        try {
            
            Familia familiaEncontrada = controlador.buscarFamiliaPorCodigo(codigo);

            if (familiaEncontrada != null) {
               
                request.setAttribute("familiaDestino", familiaEncontrada);
                
                request.getRequestDispatcher("registroMiembro.jsp").forward(request, response);
                
            } else {
                request.setAttribute("error", "El código ingresado no existe o caducó.");
                request.getRequestDispatcher("unirseFamilia.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al verificar el código.");
            request.getRequestDispatcher("unirseFamilia.jsp").forward(request, response);
        }
    }
}