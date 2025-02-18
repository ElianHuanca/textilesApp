const pool = require("../database/database");


const ObtenerDetVentas = async (req, res) => {
    try {
        const { idventas } = req.params;
        const result = await pool.query('SELECT dv.*, t.nombre FROM det_ventas dv INNER JOIN telas t ON t.id = dv.idtelas WHERE dv.idventas= $1 and dv.estado=true', [idventas]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener detalle venta:', error);
        res.status(500).json({ error: 'Error al obtener detalle venta', message: error.message });
    }
};


const RegistrarDetVentas = async (req, res) => {
    try {
        const { idventas } = req.params;
        const ventas = req.body;
        for (const venta of ventas) {
            const result = await pool.query('INSERT INTO det_ventas (idventas, idtelas, cantidad, total, ganancias,precio) VALUES ($1, $2, $3, $4, $5,$6) RETURNING id', [idventas, venta.idtelas, venta.cantidad, venta.total, venta.ganancias, venta.precio]);
            const { id } = result.rows[0];
            venta.id = id;
        }
        res.json(ventas);
    } catch (error) {
        console.error('Error al registrar detalle venta:', error);
        res.status(500).json({ error: 'Error al registrar detalle venta', message: error.message });
    }
};


const eliminarDetVenta = async (req, res) => {
    try {
        const { id } = req.params;
        const result = await pool.query('UPDATE det_ventas SET estado=false WHERE id = $1 RETURNING *', [id]);
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al eliminar detalle de venta:', error);
        res.status(500).json({ error: 'Error al eliminar detalle de venta', message: error.message });
    }

}

const ventasxtela = async (req, res) => {
    try {
        const { idusuarios } = req.params;
        const { fechaini,fechafin} = req.body;
        const result = await pool.query(`
            select dv.idtelas,t.nombre ,SUM(dv.cantidad) as cantidad,sum(dv.total) as total from det_ventas dv 
            inner join telas t on t.id =dv.idtelas and t.estado =true 
            inner join usuarios u on u.id =t.idusuarios and u.id =$1
            inner join ventas v on v.id=dv.idventas and v.fecha between $2 and $3
            group by dv.idtelas,t.nombre
          `, [idusuarios,fechaini,fechafin]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener ventas por tela:', error);
        res.status(500).json({ error: 'Error al obtener ventas por tela', message: error.message });
    }
}


module.exports = {
    ObtenerDetVentas,
    RegistrarDetVentas,
    eliminarDetVenta,
    ventasxtela
}