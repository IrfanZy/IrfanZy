const templatePdfLetter = """
    <!DOCTYPE html>
    <html>
      <style>
        body {
          background-color: white;
        }
        header > h3 {
          text-align: center;
        }
        section > p:nth-of-type(1), section > p:nth-of-type(2) {
          text-align : center;
        }
        section > div:last-of-type {
          display: flex;      
        }
        section > div:last-of-type > div:nth-of-type(1) {
          flex: 1.5;
        }
        section > div:last-of-type > div:nth-of-type(2) {
          flex: 1;
        }
        section > div:last-of-type > div > div {
          width: fit-content;
          align-items: center;
          display: flex;
          flex-direction: column;
        }
        section > div:last-of-type > div > div > div {
          height: 50px
        }
      </style>
      <body>
        <header>
          <h3>
            PEMERINTAH KABUPATEN BEKASI
            <br />
            RUKUN TETANGGA 007, RUKUN WARGA 012
            <br />
            PERUM TELAGA HARAPAN DESA TELAGA MURNI
            <br />
            CIKARANG BARAT - BEKASI
          </h3>
        </header>
        <hr />
        <section>
          <p>Surat Keterangan Pengantar</p>
          <p>........./SK/007/......../........</p>
          <br/ >
          <p>Yang bertanda tangan di bawah ini, Ketua RT.007/RW.012 Perum Telaga harapan Desa Telaga Murni Kec. Cikarang Barat, dengan ini menerangkan : </p>
          <br/ >
          <table>
            <tr>
              <td>Nama</td>
              <td style='width:20px'></td>
              <td>:</td>
              <td style='width:10px'></td>
              <td>{{nama_lengkap}}</td>
            </tr>
            <tr>
              <td>No. KTP</td>
              <td style='width:20px'></td>
              <td>:</td>
              <td style='width:10px'></td>
              <td>{{no_ktp}}</td>
            </tr>
            <tr>
              <td>Jenis Kelamin</td>
              <td style='width:20px'></td>
              <td>:</td>
              <td style='width:10px'></td>
              <td>{{jenis_kelamin}}</td>
            </tr>
            <tr>
              <td>Pekerjaan</td>
              <td style='width:20px'></td>
              <td>:</td>
              <td style='width:10px'></td>
              <td>{{pekerjaan}}</td>
            </tr>
            <tr>
              <td>Agama</td>
              <td style='width:20px'></td>
              <td>:</td>
              <td style='width:10px'></td>
              <td>{{agama}}</td>
            </tr>
            <tr>
              <td>StatusNikah</td>
              <td style='width:20px'></td>
              <td>:</td>
              <td style='width:10px'></td>
              <td>{{status_nikah}}</td>
            </tr>
            <tr>
              <td>Status Rumah</td>
              <td style='width:20px'></td>
              <td>:</td>
              <td style='width:10px'></td>
              <td>{{status_rumah}}</td>
            </tr>
            <tr>
              <td>Alamat</td>
              <td style='width:20px'></td>
              <td>:</td>
              <td style='width:10px'></td>
              <td>Perum Telaga Harapan Blok {{alamat_blok}} / No. {{alamat_blok_no}}</td>
            </tr>
            <tr>
              <td></td>
              <td style='width:20px'></td>
              <td></td>
              <td style='width:10px'></td>
              <td>RT.007/RW.021 Telaga Murni Cikarang Barat</td>
            </tr>
          </table>
          <br />
          <p> Adalah benar warga kami di lingkungan RT.07/RW.012 dengan maksud/keperluan : </p>
          <p>{{keperluan_input}}</p>
          <br />
          <p>Demikian surat keterangan ini dibuar dengan sebenarnya.</p>
          <p>Cikarang Barat, {{current_time}}</p>
          <div>
            <div>
              <div>
                <p>Ketua RT,</p>
                <div></div>
                <p>(Wawan Kurnawan)</p>
              </div>
            </div>
            <div>
              <div>
                <p>Ketua RW,</p>
                <div></div>
                <p>(................................)</p>
              </div>
            </div>
          </div>
        </section>
      </body>
    </html>
  """;
