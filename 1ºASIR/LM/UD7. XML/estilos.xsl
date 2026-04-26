<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" version="5" encoding="UTF-8" indent="yes"
              doctype-system="about:legacy-compat"/>

  <!-- ═══════════════════════════════════════════
       PLANTILLA RAÍZ
  ═══════════════════════════════════════════ -->
  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>
          <xsl:value-of select="catalogo/@nombre"/> — Catálogo de Apuestas
        </title>
        <style>
          /* ── RESET Y BASE ── */
          *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

          body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #0d0f1a;
            color: #e0e6f0;
            min-height: 100vh;
          }

          /* ── CABECERA ── */
          header {
            background: linear-gradient(135deg, #1a1d2e 0%, #0f3460 100%);
            border-bottom: 3px solid #e94560;
            padding: 2rem 1.5rem;
            text-align: center;
          }
          header h1 {
            font-size: 2.2rem;
            color: #ffffff;
            letter-spacing: 2px;
            text-transform: uppercase;
          }
          header h1 span { color: #e94560; }
          .version-badge {
            display: inline-block;
            background: #e94560;
            color: #fff;
            font-size: 0.75rem;
            font-weight: 700;
            padding: 0.2rem 0.6rem;
            border-radius: 20px;
            margin-left: 0.6rem;
            vertical-align: middle;
          }
          header p {
            color: #8892a4;
            margin-top: 0.4rem;
            font-size: 0.95rem;
          }

          /* ── CONTENEDOR PRINCIPAL ── */
          main {
            max-width: 1100px;
            margin: 2rem auto;
            padding: 0 1rem;
          }

          /* ── TARJETA DE APUESTA ── */
          .apuesta-card {
            background: #161929;
            border: 1px solid #252840;
            border-radius: 12px;
            margin-bottom: 2rem;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
          }
          .apuesta-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(233,69,96,0.25);
          }

          /* ── CABECERA DE TARJETA ── */
          .card-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1.2rem 1.5rem;
            background: #1a1d2e;
            border-bottom: 1px solid #252840;
          }
          .card-header h2 {
            font-size: 1.15rem;
            color: #ffffff;
            flex: 1;
          }

          /* ── BADGE DE DEPORTE ── */
          .sport-badge {
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            white-space: nowrap;
          }
          /* Colores por deporte – lógica condicional XSLT */
          .sport-futbol    { background: #145a32; color: #58d68d; border: 1px solid #27ae60; }
          .sport-tenis     { background: #7b6d00; color: #f4d03f; border: 1px solid #d4ac0d; }
          .sport-baloncesto{ background: #6e2d00; color: #f0a500; border: 1px solid #d35400; }
          .sport-formula1  { background: #4a0000; color: #e74c3c; border: 1px solid #c0392b; }
          .sport-ciclismo  { background: #003865; color: #5dade2; border: 1px solid #2e86c1; }
          .sport-default   { background: #2c2f3e; color: #bdc3c7; border: 1px solid #7f8c8d; }

          /* ── CUERPO DE TARJETA ── */
          .card-body {
            padding: 1.2rem 1.5rem;
          }
          .descripcion {
            color: #8892a4;
            font-size: 0.9rem;
            line-height: 1.6;
            margin-bottom: 1rem;
          }

          /* ── INFO CASA DE APUESTAS ── */
          .casa-info {
            display: flex;
            flex-wrap: wrap;
            gap: 0.6rem;
            margin-bottom: 1.2rem;
            font-size: 0.82rem;
          }
          .casa-info span {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            background: #1e2235;
            border: 1px solid #2d3250;
            border-radius: 6px;
            padding: 0.3rem 0.7rem;
            color: #a0aec0;
          }
          .casa-info .icon { font-size: 1rem; }
          .licencia-tag {
            background: #1a2e1a !important;
            border-color: #27ae60 !important;
            color: #58d68d !important;
          }
          .sin-licencia {
            background: #2e1a1a !important;
            border-color: #c0392b !important;
            color: #e74c3c !important;
            font-style: italic;
          }
          .fecha-tag {
            background: #0f2b3d !important;
            border-color: #2e86c1 !important;
            color: #5dade2 !important;
          }

          /* ── TABLA DE MERCADOS ── */
          .mercados-titulo {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #e94560;
            margin-bottom: 0.6rem;
            font-weight: 700;
          }
          table.mercados {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.85rem;
          }
          table.mercados thead tr {
            background: #0f3460;
          }
          table.mercados thead th {
            padding: 0.6rem 0.8rem;
            text-align: left;
            color: #a0c4ff;
            font-weight: 600;
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
          }
          table.mercados tbody tr:nth-child(odd)  { background: #1a1d2e; }
          table.mercados tbody tr:nth-child(even) { background: #161929; }
          table.mercados tbody tr:hover           { background: #1e2540; }
          table.mercados td {
            padding: 0.55rem 0.8rem;
            color: #c8d0e0;
            vertical-align: top;
          }
          .sel-badge {
            display: inline-block;
            background: #e94560;
            color: #fff;
            font-size: 0.7rem;
            font-weight: 700;
            padding: 0.15rem 0.5rem;
            border-radius: 10px;
          }
          /* Alerta: muchas selecciones */
          .sel-alta { background: #c0392b !important; }

          /* ── FOOTER ── */
          footer {
            text-align: center;
            padding: 1.5rem;
            color: #444c60;
            font-size: 0.8rem;
            border-top: 1px solid #1e2235;
            margin-top: 2rem;
          }
        </style>
      </head>
      <body>

        <header>
          <h1>
            <span>&#9917;</span>
            <xsl:text> </xsl:text>
            <xsl:value-of select="catalogo/@nombre"/>
            <span class="version-badge">v<xsl:value-of select="catalogo/@version"/></span>
          </h1>
          <p>Catálogo de Apuestas Deportivas — <xsl:value-of select="count(catalogo/apuesta)"/> eventos disponibles</p>
        </header>

        <main>
          <!-- ═══ REQUISITO 1 + 2: for-each con sort por deporte y luego por título ═══ -->
          <xsl:for-each select="catalogo/apuesta">
            <xsl:sort select="@deporte"  order="ascending" data-type="text"/>
            <xsl:sort select="titulo"    order="ascending" data-type="text"/>

            <article class="apuesta-card">

              <!-- ── Cabecera de la tarjeta ── -->
              <div class="card-header">
                <h2><xsl:value-of select="titulo"/></h2>

                <!-- ═══ REQUISITO 3: choose para el badge de color por deporte ═══ -->
                <xsl:choose>
                  <xsl:when test="@deporte = 'Fútbol'">
                    <span class="sport-badge sport-futbol">&#9917; Fútbol</span>
                  </xsl:when>
                  <xsl:when test="@deporte = 'Tenis'">
                    <span class="sport-badge sport-tenis">&#127955; Tenis</span>
                  </xsl:when>
                  <xsl:when test="@deporte = 'Baloncesto'">
                    <span class="sport-badge sport-baloncesto">&#127936; Baloncesto</span>
                  </xsl:when>
                  <xsl:when test="@deporte = 'Fórmula 1'">
                    <span class="sport-badge sport-formula1">&#127950; Fórmula 1</span>
                  </xsl:when>
                  <xsl:when test="@deporte = 'Ciclismo'">
                    <span class="sport-badge sport-ciclismo">&#128690; Ciclismo</span>
                  </xsl:when>
                  <xsl:otherwise>
                    <span class="sport-badge sport-default">&#127941; <xsl:value-of select="@deporte"/></span>
                  </xsl:otherwise>
                </xsl:choose>
              </div>

              <!-- ── Cuerpo de la tarjeta ── -->
              <div class="card-body">
                <p class="descripcion"><xsl:value-of select="descripcion"/></p>

                <!-- Metadatos: casa, país, licencia, fecha -->
                <div class="casa-info">
                  <span><span class="icon">&#127968;</span> <xsl:value-of select="casa_de_apuestas/nombre"/></span>
                  <span><span class="icon">&#127757;</span> <xsl:value-of select="casa_de_apuestas/pais"/></span>

                  <!-- ═══ REQUISITO 3: if para mostrar licencia o aviso sin licencia ═══ -->
                  <xsl:if test="casa_de_apuestas/licencia">
                    <span class="licencia-tag">
                      <span class="icon">&#9989;</span> Licencia: <xsl:value-of select="casa_de_apuestas/licencia"/>
                    </span>
                  </xsl:if>
                  <xsl:if test="not(casa_de_apuestas/licencia)">
                    <span class="sin-licencia">
                      <span class="icon">&#9888;&#65039;</span> Sin licencia publicada
                    </span>
                  </xsl:if>

                  <span class="fecha-tag">
                    <span class="icon">&#128197;</span> <xsl:value-of select="condiciones/fecha_evento"/>
                  </span>
                </div>

                <!-- Tabla de mercados -->
                <p class="mercados-titulo">&#128200; Mercados disponibles</p>
                <table class="mercados">
                  <thead>
                    <tr>
                      <th>Mercado</th>
                      <th>Selecciones</th>
                      <th>Descripción</th>
                    </tr>
                  </thead>
                  <tbody>
                    <!-- ═══ REQUISITO 1: for-each para los mercados de cada apuesta ═══ -->
                    <xsl:for-each select="condiciones/mercado">
                      <tr>
                        <td><strong><xsl:value-of select="@nombre_mercado"/></strong></td>
                        <td>
                          <!-- ═══ REQUISITO 3: choose — alerta si hay más de 10 selecciones ═══ -->
                          <xsl:choose>
                            <xsl:when test="num_selecciones &gt; 10">
                              <span class="sel-badge sel-alta">
                                <xsl:value-of select="num_selecciones"/>
                              </span>
                            </xsl:when>
                            <xsl:otherwise>
                              <span class="sel-badge">
                                <xsl:value-of select="num_selecciones"/>
                              </span>
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                        <td><xsl:value-of select="descripcion_mercado"/></td>
                      </tr>
                    </xsl:for-each>
                  </tbody>
                </table>

              </div>
            </article>
          </xsl:for-each>
        </main>

        <footer>
          <p>&#169; 2025 <xsl:value-of select="catalogo/@nombre"/> — Generado mediante transformación XSLT</p>
          <p>El juego puede crear adicción. Juega con responsabilidad. +18.</p>
        </footer>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
