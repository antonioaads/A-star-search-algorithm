distance = {"Arad" 366;
            "Bucharest" 0;
            "Craiova" 160;
            "Dobreta" 242;
            "Eforie" 161;
            "Fagaras" 176;
            "Giurgiu" 77;
            "Hirsova" 151;
            "Iasi" 226;
            "Lugoj" 244;
            "Mehadia" 241;
            "Neamt" 234;
            "Oradea" 380;
            "Pitesti" 101;
            "Rimnicu Vilcea" 193;
            "Sibiu" 253;
            "Timisoara" 329;
            "Urziceni" 80;
            "Vaslui" 199;
            "Zerind" 374 
            };
             
node = { "Oradea" "Zerind" 71;
         "Oradea" "Sibiu" 151;
         "Zerind" "Arad" 75;
         "Zerind" "Oradea" 71;
         "Arad" "Zerind" 75;
         "Arad" "Sibiu" 140;
         "Arad" "Timisoara" 118;
         "Sibiu" "Arad" 140;
         "Sibiu" "Oradea" 151;
         "Sibiu" "Fagaras" 99;
         "Sibiu" "Rimnicu Vilcea" 80;
         "Timisoara" "Arad" 118;
         "Timisoara" "Lugoj" 111;
         "Lugoj" "Timisoara" 111;
         "Lugoj" "Mehadia" 70;
         "Mehadia" "Lugoj" 70;
         "Mehadia" "Dobreta" 75;
         "Dobreta" "Mehadia" 75;
         "Dobreta" "Craiova" 120;
         "Craiova" "Dobreta" 120;
         "Craiova" "Rimnicu Vilcea" 146;
         "Craiova" "Pitesti" 138;
         "Rimnicu Vilcea" "Craiova" 146;
         "Rimnicu Vilcea" "Sibiu" 80;
         "Rimnicu Vilcea" "Pitesti" 97;
         "Pitesti" "Rimnicu Vilcea" 97;
         "Pitesti" "Craiova" 138;
         "Pitesti" "Bucharest" 101;
         "Fagaras" "Sibiu" 99;
         "Fagaras" "Bucharest" 211;
         "Giurgiu" "Bucharest" 90;
         "Neamt" "Iasi" 87;
         "Iasi" "Neamt" 87;
         "Iasi" "Vaslui" 92;
         "Vaslui" "Iasi" 92;
         "Vaslui" "Urziceni" 142;
         "Urziceni" "Vaslui" 142;
         "Urziceni" "Hirsova" 98;
         "Urziceni" "Bucharest" 85;
         "Hirsova" "Urziceni" 98;
         "Hirsova" "Eforie" 86;
         "Eforie" "Hirsova" 86;
         };
   
city_source = "Arad";
city_destiny = "Bucharest";
city_choice = city_source;

#matrix level / city / distance
#matrix = {1000,3};
# indicates how many rows are there in the matrix
row = 1;
# indicates which level the city is
level = 1;

for i=1:20
    city = distance{i,1};
    if (strcmp(city, city_choice) == 1)
        printf("\nDistancia de %s até %s: %d\n", city, city_destiny, distance{i,2});
        
        for j=1:42 #show the possible routes/paths
            if(strcmp(node{j,1},city) == 1)
                for c=1:20 #find distance between neighbor and Bucharest
                    neighbor = distance{c,1};
                    if (strcmp(neighbor, node{j,2}) == 1)
                        distanceToBucharest = distance{c,2}; #save distance
                        city_origin = node{j,1};
                        city_node = node{j,2};
                        city_distance = node{j,3};
                        distance_total = city_distance + distanceToBucharest;
                        break;
                    endif
                endfor
                printf("%s ate %s >>\t %d + %d = %d\n", city_origin, city_node, city_distance, distanceToBucharest, distance_total);  
                # insert data in matrix
                matrix{row, 2,3} = [level, city_node, distance_total];
                row = row + 1;
            endif
        endfor
        # Select city with shortest distance > (node{j,3}+dist)
          # check matrix
          # city_choice = city_with_shortest_distance;
          # printf("Cidade escolhida: %s", city_choice);
        
        # Chegou a Bucareste? 
          # if(dist == 0) #significa que chegou a Bucareste
        
    endif
    
endfor




