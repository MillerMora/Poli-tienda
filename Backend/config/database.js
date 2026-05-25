const sqlServer = require('mssql')

const dbConfig = {
    user: 'adminTienda',
    password: '12345@Poli',
    server: 'DESKTOP-EOT0HL3\SQLEXPRESS',
    database: 'politienda',
    options: {
        encrypt: false,
        TrustServerCertificate: true
    }
}

const conexion = async()=>{
    const pool = await sqlServer.connect(dbConfig)
    return pool
}

module.exports = conexion