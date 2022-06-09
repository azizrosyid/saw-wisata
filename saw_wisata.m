function dataset = saw_wisata(cityPicked, weightCriteria, valueCategory)
% cityPicked - Kota yang dipilih oleh user melalui GUI
% weightCriteria - Bobot setiap kriteria yang dimasukkan user
% valueCategory - Nilai Preferensi dari kategori sesuai user
% return dataset - return nilai berupa dataset yang didalamnya terdapat hasil dari perhitungan SAW

% read dataset
dataset = readtable('tourism_with_id.csv');
dataset = removevars(dataset,["Place_Id" "Time_Minutes" "Coordinate", "Lat", "Long", "Var12", "Var13"]);

% filter kota
picked = ismember(dataset.City, cityPicked);
dataset(not(picked), :) = [];

% mengisi nilai tiket masuk
price1 = dataset.Price <= 5000;
dataset.PriceValue(price1) = 1;

price2 = dataset.Price > 5000 & dataset.Price <= 10000;
dataset.PriceValue(price2) = 2;

price3 = dataset.Price > 10000 & dataset.Price <= 25000;
dataset.PriceValue(price3) = 3;

price4 = dataset.Price > 25000 & dataset.Price <= 50000;
dataset.PriceValue(price4) = 4;

price5 = dataset.Price > 50000;
dataset.PriceValue(price5) = 5;

% mengisi nilai kategori
for index = 1:length(valueCategory)
    name = string(valueCategory{index});
    value = string(valueCategory{index,2});
    value = str2double(value);
    
    dataset.CategoryValue(dataset.Category == name) = value;
end

% membuat dataset untuk perhitungan
datasetSAW = [dataset.PriceValue dataset.Rating dataset.CategoryValue];

% menormalisasi bobot
weightCriteria = weightCriteria ./ sum(weightCriteria);
typeCriteria = ["COST", "BENEFIT", "BENEFIT"];

[rowLength, columnLength] = size(datasetSAW);

% menormalisasi kriteria
normalizeMatrix = zeros(rowLength, columnLength);
for j=1:columnLength
    if typeCriteria(j) == "BENEFIT"
        normalizeMatrix(:,j)= datasetSAW(:,j) ./ max(datasetSAW(:,j));
    else
        normalizeMatrix(:,j)= min(datasetSAW(:,j)) ./ datasetSAW(:,j);
    end
end

% mengalikan matrix dengan bobot kriteria
resultMatrix = zeros(rowLength, 1);
for i=1:rowLength
    resultMatrix(i) = sum(weightCriteria .* normalizeMatrix(i,:));
end

dataset.Result = resultMatrix;
dataset = sortrows(dataset, 'Result', 'descend');
dataset = head(dataset, 10);