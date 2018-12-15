
analysis = menu('Modo de cálculo', 'Lat, Long e TC', 'Coordenadas de dois pontos');
switch(analysis)
    case (1) 
        titulo = 'Dados';
        campos = {'Latitude:', 'Longitude:', 'True Course:'};
        dados =  inputdlg(campos, titulo);
        return;
    case (2)
        titulo = 'Dados';
        campos = {'Latitude 1:', 'Longitude 1:', 'Latitude 2:', 'Longitude 2:'};
        dados =  inputdlg(campos, titulo);
        return;
end