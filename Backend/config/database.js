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
    try {
        const pool = await sqlServer.connect(dbConfig)
        return pool
        
    } catch (error) {
        console.log('Error en la conexion: ',error)
    }
}

module.exports = conexion