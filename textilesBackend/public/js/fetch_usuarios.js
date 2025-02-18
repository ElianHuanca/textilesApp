
// Función para consumir la API
async function fetchApiData() {
    try {
        const response = await fetch('http://localhost:8080/api/usuarios'); // Ejemplo de API
        const data = await response.json();

        // Selecciona el tbody de la tabla
        const tableBody = document.getElementById('data-table');

        // Itera sobre los datos de la API y crea las filas de la tabla
        data.forEach(user => {
            const row = document.createElement('tr');
            row.innerHTML = `
                    <td>${user.id}</td>
                    <td>${user.nombre}</td>
                    <td>${user.correo}</td>
                `;
            tableBody.appendChild(row);
        });
    } catch (error) {
        console.error('Error al consumir la API:', error);
    }
}

// Llama a la función para obtener los datos
fetchApiData();