
package com.prog.tpi_colonia_felina_paii.vista;

import com.prog.tpi_colonia_felina_paii.controlador.ControladorHistorialMedico;
import com.prog.tpi_colonia_felina_paii.modelo.Diagnostico;
import com.prog.tpi_colonia_felina_paii.modelo.Estudio;
import com.prog.tpi_colonia_felina_paii.modelo.Gato;
import com.prog.tpi_colonia_felina_paii.modelo.HistorialMedico;
import com.prog.tpi_colonia_felina_paii.modelo.Tratamiento;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;


public class HistorialMedicoFrame extends javax.swing.JFrame {

    private final ControladorHistorialMedico controlador;
    private final Long idGato;
    private final Long idVeterinarioActual;

    private DiagnosticosTableModel diagnosticosModel;
    private TratamientosTableModel tratamientosModel;
    private EstudiosTableModel estudiosModel;
    
    
    public HistorialMedicoFrame(ControladorHistorialMedico controlador,
                                Long idGato,
                                Long idVeterinarioActual) {
        this.controlador = controlador;
        this.idGato = idGato;
        this.idVeterinarioActual = idVeterinarioActual;

        initComponents();           // generado por NetBeans
        setLocationRelativeTo(null);

        inicializarModelosYListeners();
        cargarDatos();
    }
    
     private void inicializarModelosYListeners() {
        diagnosticosModel = new DiagnosticosTableModel();
        tablaDiagnosticos.setModel(diagnosticosModel);

        tratamientosModel = new TratamientosTableModel();
        tablaTratamientos.setModel(tratamientosModel);

        estudiosModel = new EstudiosTableModel();
        tablaEstudios.setModel(estudiosModel);

        // Cuando se selecciona un diagnóstico, cargamos sus tratamientos
        tablaDiagnosticos.getSelectionModel().addListSelectionListener(e -> {
            if (!e.getValueIsAdjusting()) {
                cargarTratamientosDelDiagnosticoSeleccionado();
            }
        });

        btnNuevoDiagnostico.addActionListener(e -> abrirDialogoNuevoDiagnostico());
        btnNuevoTratamiento.addActionListener(e -> abrirDialogoNuevoTratamiento());
        btnNuevoEstudio.addActionListener(e -> abrirDialogoNuevoEstudio());
    }

    private void cargarDatos() {
        try {
            HistorialMedico historial = controlador.obtenerHistorialDeGato(idGato);
            Gato gato = historial.getGato();

            lblNombreGato.setText("Nombre: " + (gato.getNombre() != null ? gato.getNombre() : "(sin nombre)"));
            lblColorGato.setText("Color: " + gato.getColor());
            lblEstadoSalud.setText("Estado: " + gato.getEstadoSalud());

            List<Diagnostico> diagnos = controlador.obtenerDiagnosticosDeGato(idGato);
            diagnosticosModel.setDatos(diagnos);

            List<Estudio> estudios = controlador.obtenerEstudiosDeGato(idGato);
            estudiosModel.setDatos(estudios);

            tratamientosModel.setDatos(new ArrayList<>());

        } catch (IllegalArgumentException ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            dispose();
        }
    }

    private void cargarTratamientosDelDiagnosticoSeleccionado() {
        int fila = tablaDiagnosticos.getSelectedRow();
        if (fila < 0) {
            tratamientosModel.setDatos(new ArrayList<>());
            return;
        }
        Diagnostico d = diagnosticosModel.getDiagnosticoEn(fila);
        List<Tratamiento> lista = d.getTratamientos();
        lista.size(); // forzar carga si es LAZY
        tratamientosModel.setDatos(lista);
    }

    private void abrirDialogoNuevoDiagnostico() {
        // Acá podés usar el diálogo que armamos antes (o uno simple)
        JOptionPane.showMessageDialog(this, "Acá abrís NuevoDiagnosticoDialog", "Info", JOptionPane.INFORMATION_MESSAGE);
        // luego:
        // new NuevoDiagnosticoDialog(this, controlador, idGato, idVeterinarioActual).setVisible(true);
        // cargarDatos();
    }

    private void abrirDialogoNuevoTratamiento() {
        int fila = tablaDiagnosticos.getSelectedRow();
        if (fila < 0) {
            JOptionPane.showMessageDialog(this, "Seleccione un diagnóstico primero.");
            return;
        }
        Diagnostico d = diagnosticosModel.getDiagnosticoEn(fila);
        JOptionPane.showMessageDialog(this, "Acá abrís NuevoTratamientoDialog para diag=" + d.getIdDiagnostico(), "Info", JOptionPane.INFORMATION_MESSAGE);
        // luego:
        // new NuevoTratamientoDialog(this, controlador, d.getId(), idVeterinarioActual).setVisible(true);
        // cargarDatos();
        // cargarTratamientosDelDiagnosticoSeleccionado();
    }

    private void abrirDialogoNuevoEstudio() {
        JOptionPane.showMessageDialog(this, "Acá abrís NuevoEstudioDialog", "Info", JOptionPane.INFORMATION_MESSAGE);
        // luego:
        // new NuevoEstudioDialog(this, controlador, idGato, idVeterinarioActual).setVisible(true);
        // cargarDatos();
    }

    
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel3 = new javax.swing.JPanel();
        jPanel1 = new javax.swing.JPanel();
        lblNombreGato = new javax.swing.JLabel();
        lblColorGato = new javax.swing.JLabel();
        lblEstadoSalud = new javax.swing.JLabel();
        tabbedPane = new javax.swing.JTabbedPane();
        panelDiagnosticos = new javax.swing.JPanel();
        jScrollPaneDiag = new javax.swing.JScrollPane();
        tablaDiagnosticos = new javax.swing.JTable();
        jScrollPaneTrat = new javax.swing.JScrollPane();
        tablaTratamientos = new javax.swing.JTable();
        panelEstudios = new javax.swing.JPanel();
        jScrollPaneEst = new javax.swing.JScrollPane();
        tablaEstudios = new javax.swing.JTable();
        panelBotones = new javax.swing.JPanel();
        btnNuevoDiagnostico = new javax.swing.JButton();
        btnNuevoTratamiento = new javax.swing.JButton();
        btnNuevoEstudio = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel3.setBackground(new java.awt.Color(175, 177, 179));

        jPanel1.setBackground(new java.awt.Color(255, 255, 255));
        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(41, 43, 45)), "Datos del gato", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 1, 18), new java.awt.Color(0, 0, 0))); // NOI18N

        lblNombreGato.setBackground(javax.swing.UIManager.getDefaults().getColor("TextField.darkShadow"));
        lblNombreGato.setFont(new java.awt.Font("Segoe UI", 1, 24)); // NOI18N
        lblNombreGato.setForeground(javax.swing.UIManager.getDefaults().getColor("nb.startpage.contentheader.color2"));
        lblNombreGato.setText("Nombre:");
        jPanel1.add(lblNombreGato);

        lblColorGato.setFont(new java.awt.Font("Segoe UI", 1, 24)); // NOI18N
        lblColorGato.setForeground(new java.awt.Color(0, 0, 0));
        lblColorGato.setText("Color:");
        jPanel1.add(lblColorGato);

        lblEstadoSalud.setFont(new java.awt.Font("Segoe UI", 1, 24)); // NOI18N
        lblEstadoSalud.setForeground(new java.awt.Color(0, 0, 0));
        lblEstadoSalud.setText("Estado:");
        jPanel1.add(lblEstadoSalud);

        tablaDiagnosticos.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        jScrollPaneDiag.setViewportView(tablaDiagnosticos);

        tablaTratamientos.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        jScrollPaneTrat.setViewportView(tablaTratamientos);

        javax.swing.GroupLayout panelDiagnosticosLayout = new javax.swing.GroupLayout(panelDiagnosticos);
        panelDiagnosticos.setLayout(panelDiagnosticosLayout);
        panelDiagnosticosLayout.setHorizontalGroup(
            panelDiagnosticosLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(panelDiagnosticosLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(panelDiagnosticosLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPaneDiag, javax.swing.GroupLayout.DEFAULT_SIZE, 652, Short.MAX_VALUE)
                    .addComponent(jScrollPaneTrat))
                .addContainerGap())
        );
        panelDiagnosticosLayout.setVerticalGroup(
            panelDiagnosticosLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(panelDiagnosticosLayout.createSequentialGroup()
                .addComponent(jScrollPaneDiag, javax.swing.GroupLayout.PREFERRED_SIZE, 92, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPaneTrat, javax.swing.GroupLayout.PREFERRED_SIZE, 89, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 4, Short.MAX_VALUE))
        );

        tabbedPane.addTab("Diagnósticos", panelDiagnosticos);

        tablaEstudios.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        jScrollPaneEst.setViewportView(tablaEstudios);

        javax.swing.GroupLayout panelEstudiosLayout = new javax.swing.GroupLayout(panelEstudios);
        panelEstudios.setLayout(panelEstudiosLayout);
        panelEstudiosLayout.setHorizontalGroup(
            panelEstudiosLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(panelEstudiosLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPaneEst, javax.swing.GroupLayout.DEFAULT_SIZE, 652, Short.MAX_VALUE)
                .addContainerGap())
        );
        panelEstudiosLayout.setVerticalGroup(
            panelEstudiosLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(panelEstudiosLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPaneEst, javax.swing.GroupLayout.DEFAULT_SIZE, 167, Short.MAX_VALUE)
                .addGap(24, 24, 24))
        );

        tabbedPane.addTab("Estudios", panelEstudios);

        panelBotones.setBackground(new java.awt.Color(175, 177, 179));

        btnNuevoDiagnostico.setBackground(new java.awt.Color(255, 153, 51));
        btnNuevoDiagnostico.setFont(new java.awt.Font("Segoe UI", 0, 18)); // NOI18N
        btnNuevoDiagnostico.setForeground(new java.awt.Color(0, 0, 0));
        btnNuevoDiagnostico.setText("Nuevo diagnóstico");
        panelBotones.add(btnNuevoDiagnostico);

        btnNuevoTratamiento.setBackground(new java.awt.Color(255, 153, 51));
        btnNuevoTratamiento.setFont(new java.awt.Font("Segoe UI", 0, 18)); // NOI18N
        btnNuevoTratamiento.setForeground(new java.awt.Color(0, 0, 0));
        btnNuevoTratamiento.setText("Nuevo tratamiento");
        btnNuevoTratamiento.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnNuevoTratamientoActionPerformed(evt);
            }
        });
        panelBotones.add(btnNuevoTratamiento);

        btnNuevoEstudio.setBackground(new java.awt.Color(255, 153, 51));
        btnNuevoEstudio.setFont(new java.awt.Font("Segoe UI", 0, 18)); // NOI18N
        btnNuevoEstudio.setForeground(new java.awt.Color(0, 0, 0));
        btnNuevoEstudio.setText("Nuevo estudio");
        panelBotones.add(btnNuevoEstudio);

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(67, 67, 67)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(tabbedPane, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addGap(60, 60, 60)
                        .addComponent(panelBotones, javax.swing.GroupLayout.PREFERRED_SIZE, 513, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(68, Short.MAX_VALUE))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, 103, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(tabbedPane, javax.swing.GroupLayout.PREFERRED_SIZE, 223, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(54, 54, 54)
                .addComponent(panelBotones, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(59, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnNuevoTratamientoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnNuevoTratamientoActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_btnNuevoTratamientoActionPerformed

    
   

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnNuevoDiagnostico;
    private javax.swing.JButton btnNuevoEstudio;
    private javax.swing.JButton btnNuevoTratamiento;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JScrollPane jScrollPaneDiag;
    private javax.swing.JScrollPane jScrollPaneEst;
    private javax.swing.JScrollPane jScrollPaneTrat;
    private javax.swing.JLabel lblColorGato;
    private javax.swing.JLabel lblEstadoSalud;
    private javax.swing.JLabel lblNombreGato;
    private javax.swing.JPanel panelBotones;
    private javax.swing.JPanel panelDiagnosticos;
    private javax.swing.JPanel panelEstudios;
    private javax.swing.JTabbedPane tabbedPane;
    private javax.swing.JTable tablaDiagnosticos;
    private javax.swing.JTable tablaEstudios;
    private javax.swing.JTable tablaTratamientos;
    // End of variables declaration//GEN-END:variables
     
    private static class DiagnosticosTableModel extends AbstractTableModel {
        private List<Diagnostico> datos = new ArrayList<>();
        private final String[] cols = {"Fecha", "Descripción", "Estado clínico", "Veterinario"};

        public void setDatos(List<Diagnostico> datos) {
            this.datos = datos != null ? datos : new ArrayList<>();
            fireTableDataChanged();
        }

        public Diagnostico getDiagnosticoEn(int fila) {
            return datos.get(fila);
        }

        @Override public int getRowCount() { return datos.size(); }
        @Override public int getColumnCount() { return cols.length; }
        @Override public String getColumnName(int col) { return cols[col]; }

        @Override
        public Object getValueAt(int rowIndex, int columnIndex) {
            Diagnostico d = datos.get(rowIndex);
            return switch (columnIndex) {
                case 0 -> d.getFecha();
                case 1 -> d.getDescDetallada();
                case 2 -> d.getEstadoClinico();
                case 3 -> d.getVeterinario().getCorreo();
                default -> "";
            };
        }
    }

    private static class TratamientosTableModel extends AbstractTableModel {
        private List<Tratamiento> datos = new ArrayList<>();
        private final String[] cols = {"Fecha", "Descripción", "Medicación", "Veterinario"};

        public void setDatos(List<Tratamiento> datos) {
            this.datos = datos != null ? datos : new ArrayList<>();
            fireTableDataChanged();
        }

        @Override public int getRowCount() { return datos.size(); }
        @Override public int getColumnCount() { return cols.length; }
        @Override public String getColumnName(int col) { return cols[col]; }

        @Override
        public Object getValueAt(int rowIndex, int columnIndex) {
            Tratamiento t = datos.get(rowIndex);
            return switch (columnIndex) {
                case 0 -> t.getFechaTratamiento();
                case 1 -> t.getDescripcion();
                case 2 -> t.getMedicacion();
                case 3 -> t.getVeterinario().getCorreo();
                default -> "";
            };
        }
    }

    private static class EstudiosTableModel extends AbstractTableModel {
        private List<Estudio> datos = new ArrayList<>();
        private final String[] cols = {"Fecha", "Tipo", "Observaciones", "Archivo", "Veterinario"};

        public void setDatos(List<Estudio> datos) {
            this.datos = datos != null ? datos : new ArrayList<>();
            fireTableDataChanged();
        }

        @Override public int getRowCount() { return datos.size(); }
        @Override public int getColumnCount() { return cols.length; }
        @Override public String getColumnName(int col) { return cols[col]; }

        @Override
        public Object getValueAt(int rowIndex, int columnIndex) {
            Estudio e = datos.get(rowIndex);
            return switch (columnIndex) {
                case 0 -> e.getFecha();
                case 1 -> e.getTipoDeEstudio();
                case 2 -> e.getObservaciones();
                case 3 -> e.getRutaArchivo();
                case 4 -> e.getVeterinario().getCorreo();
                default -> "";
            };
        }
    }
}

