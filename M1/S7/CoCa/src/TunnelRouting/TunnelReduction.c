#include "TunnelReduction.h"
#include "Z3Tools.h"
#include "stdio.h"

/**
 * @brief Creates the variable "x_{node,pos,stack_height}" of the reduction (described in the subject).
 *
 * @param ctx The solver context.
 * @param node A node.
 * @param pos The path position.
 * @param stack_height The highest cell occupied of the stack at that position.
 * @return Z3_ast
 */
Z3_ast tn_path_variable(Z3_context ctx, int node, int pos, int stack_height)
{
    char name[60];
    snprintf(name, 60, "node %d,pos %d, height %d", node, pos, stack_height);
    return mk_bool_var(ctx, name);
}

/**
 * @brief Creates the variable "y_{pos,height,4}" of the reduction (described in the subject).
 *
 * @param ctx The solver context.
 * @param pos The path position.
 * @param height The height of the cell described.
 * @return Z3_ast
 */
Z3_ast tn_4_variable(Z3_context ctx, int pos, int height)
{
    char name[60];
    snprintf(name, 60, "4 at height %d on pos %d", height, pos);
    return mk_bool_var(ctx, name);
}

/**
 * @brief Creates the variable "y_{pos,height,6}" of the reduction (described in the subject).
 *
 * @param ctx The solver context.
 * @param pos The path position.
 * @param height The height of the cell described.
 * @return Z3_ast
 */
Z3_ast tn_6_variable(Z3_context ctx, int pos, int height)
{
    char name[60];
    snprintf(name, 60, "6 at height %d on pos %d", height, pos);
    return mk_bool_var(ctx, name);
}

/**
 * @brief Wrapper to have the correct size of the array representing the stack (correct cells of the stack will be from 0 to (get_stack_size(length)-1)).
 *
 * @param length The length of the sought path.
 * @return int
 */
int get_stack_size(int length)
{
    return length / 2 + 1;

}

Z3_ast phi1_unique(Z3_context ctx, const TunnelNetwork network, int length) {
    int stack_size = get_stack_size(length);
    int num_nodes = tn_get_num_nodes(network);
    
    // Tableau pour stocker les contraintes
    Z3_ast constraints[length + 1];
    
    for (int i = 0; i <= length; i++) {

        Z3_ast tab_variables[num_nodes * stack_size];
        int var_count = 0;
        
        for (int node = 0; node < num_nodes; node++) {
            for (int h = 0; h < stack_size; h++) {
                tab_variables[var_count++] = tn_path_variable(ctx, node, i, h); //X_{op, i, h}
            }
        }
        
        constraints[i] = uniqueFormula(ctx, tab_variables, var_count);
    }
    //Conjonction de toutes les contraintes
    return Z3_mk_and(ctx, length + 1, constraints);
}

Z3_ast phi2_start_end(Z3_context ctx, const TunnelNetwork network, int length) {
    int initial_node = tn_get_initial(network);
    int final_node = tn_get_final(network);
    
    if (!tn_node_has_action(network, initial_node, transmit_4)) {
        return Z3_mk_false(ctx);
    }
    
    // (X_{start_node, 0, 0} AND Y_{0, 0, 4})
    // 1. Le chemin commence à 0.
    // 2. La pile est de hauteur 0 et contient l'élément '4' (état : |4|)
    Z3_ast start = Z3_mk_and(ctx, 2, (Z3_ast[]){tn_path_variable(ctx, initial_node, 0, 0),tn_4_variable(ctx, 0, 0)});
    
    // (X_{end_node, length, 0} AND Y_{length, 0, 4})
    // 1. Le chemin finit a 'length'.
    // 2. La pile est de hauteur 0 et contient l'élément '4' (état : |4|)
    Z3_ast end = Z3_mk_and(ctx, 2, (Z3_ast[]){tn_path_variable(ctx, final_node, length, 0),tn_4_variable(ctx, length, 0)});
    
    return Z3_mk_and(ctx, 2, (Z3_ast[]){start, end});
}

Z3_ast phi3_push(Z3_context ctx, const TunnelNetwork network, int length) {
    Z3_ast formula = Z3_mk_true(ctx);
    int num_nodes = tn_get_num_nodes(network);
    int stack_size = get_stack_size(length);
    
    // tous les positions du chemin
    for (int i = 0; i < length; i++) {
        // toutes les hauteurs de la pile
        for (int h = 0; h < stack_size; h++) {
            // tous les noeuds
            for (int node = 0; node < num_nodes; node++) {
                // si le noeud peut push
                bool can_push = tn_node_has_action(network, node, push_4_4) ||
                               tn_node_has_action(network, node, push_4_6) ||
                               tn_node_has_action(network, node, push_6_4) ||
                               tn_node_has_action(network, node, push_6_6);
                
                if (!can_push) continue;  //s'il peut pas push on ignore
                
                // correspond au nœud à la position i avec pile de hauteur h
                Z3_ast current = tn_path_variable(ctx, node, i, h);
                
                // initialisé à faux au cas où, correspond à un état suivant valide
                Z3_ast next_exists = Z3_mk_false(ctx);
                
                // tous les noeuds suivant possibles
                for (int next_node = 0; next_node < num_nodes; next_node++) {
                    if (!tn_is_edge(network, node, next_node)) continue;  // si une arête existe
                    
                    // push, hauteur de pile augmente de un
                    if (h + 1 < stack_size) { // on check si on est toujours dans la pile
                        Z3_ast next_state = tn_path_variable(ctx, next_node, i + 1, h + 1);
                        next_exists = Z3_mk_or(ctx, 2, (Z3_ast[]){next_exists, next_state});
                    }
                }
                
                Z3_ast implication = Z3_mk_implies(ctx, current, next_exists);
                formula = Z3_mk_and(ctx, 2, (Z3_ast[]){formula, implication});
            }
        }
    }
    return formula;
}

Z3_ast phi3_transmit(Z3_context ctx, const TunnelNetwork network, int length) {
    Z3_ast formula = Z3_mk_true(ctx); 
    int num_nodes = tn_get_num_nodes(network);
    int stack_size = get_stack_size(length);
    
    // tous les positions du chemin
    for (int i = 0; i < length; i++) {
        // toutes les hauteurs de la pile
        for (int h = 0; h < stack_size; h++) {
            // tous les noeuds
            for (int node = 0; node < num_nodes; node++) {
                //si le noeud peut transmit
                bool can_transmit = tn_node_has_action(network, node, transmit_4) ||
                                   tn_node_has_action(network, node, transmit_6);
                
                if (!can_transmit) continue;  // s'il peut pas transmit on ignore
                
                // correspond au nœud à la position i avec pile de hauteur h
                Z3_ast current = tn_path_variable(ctx, node, i, h);
                
                // initialisé à faux au cas où, correspond à un état suivant valide
                Z3_ast next_exists = Z3_mk_false(ctx);

                // tous les noeuds suivant possibles
                for (int next_node = 0; next_node < num_nodes; next_node++) {
                    if (!tn_is_edge(network, node, next_node)) continue;
                    
                    // transmit, hauteur de ne change pas
                    Z3_ast next_state = tn_path_variable(ctx, next_node, i + 1, h);
                    next_exists = Z3_mk_or(ctx, 2, (Z3_ast[]){next_exists, next_state});
                }
                
                Z3_ast implication = Z3_mk_implies(ctx, current, next_exists);
                formula = Z3_mk_and(ctx, 2, (Z3_ast[]){formula, implication});
            }
        }
    }
    return formula;
}

Z3_ast phi3_pop(Z3_context ctx, const TunnelNetwork network, int length) {
    Z3_ast formula = Z3_mk_true(ctx);  // Initialise la formule à VRAI
    int num_nodes = tn_get_num_nodes(network);
    int stack_size = get_stack_size(length);
    
    // tous les positions du chemin
    for (int i = 0; i < length; i++) {
        // toutes les hauteurs de la pile
        for (int h = 0; h < stack_size; h++) {
            // tous les noeuds
            for (int node = 0; node < num_nodes; node++) {
                //si le noeud peut pop
                bool can_pop = tn_node_has_action(network, node, pop_4_4) ||
                              tn_node_has_action(network, node, pop_4_6) ||
                              tn_node_has_action(network, node, pop_6_4) ||
                              tn_node_has_action(network, node, pop_6_6);
                
                if (!can_pop) continue;  // s'il peut pas pop on ignore

                // correspond au nœud à la position i avec pile de hauteur h
                Z3_ast current = tn_path_variable(ctx, node, i, h);
                
                // initialisé à faux au cas où, correspond à un état suivant valide
                Z3_ast next_exists = Z3_mk_false(ctx);

                // tous les noeuds suivant possibles
                for (int next_node = 0; next_node < num_nodes; next_node++) {
                    if (!tn_is_edge(network, node, next_node)) continue;
                    
                    // pop, hauteur diminue de 1
                    if (h - 1 >= 0) {  // on check si on est toujours dans la pile
                        Z3_ast next_state = tn_path_variable(ctx, next_node, i + 1, h - 1);
                        next_exists = Z3_mk_or(ctx, 2, (Z3_ast[]){next_exists, next_state});
                    }
                }
                
                Z3_ast implication = Z3_mk_implies(ctx, current, next_exists);
                formula = Z3_mk_and(ctx, 2, (Z3_ast[]){formula, implication});
            }
        }
    }
    return formula;
}

Z3_ast phi3_complete(Z3_context ctx, const TunnelNetwork network, int length)
{
    Z3_ast formula = Z3_mk_and(ctx, 3, (Z3_ast[]){
        phi3_push(ctx, network, length),
        phi3_pop(ctx, network, length),
        phi3_transmit(ctx, network, length)
    });
    
    return formula;
}



Z3_ast phi4_stack_structure(Z3_context ctx, const TunnelNetwork network, int length) {
int stack_size = get_stack_size(length);
    int num_nodes = tn_get_num_nodes(network);
    
    // Tableau pour stocker les contraintes
    Z3_ast all_constraints[length + 1];
    
    for (int i = 0; i <= length; i++) {
        
        Z3_ast pos_constraints[num_nodes * stack_size];
        int constraint_count = 0;
        
        for (int h_act = 0; h_act < stack_size; h_act++) {
            
            Z3_ast x_at_h_act = Z3_mk_false(ctx);
            for (int node = 0; node < num_nodes; node++) {
                x_at_h_act = Z3_mk_or(ctx, 2, (Z3_ast[]){x_at_h_act, tn_path_variable(ctx, node, i, h_act)});
            }
            // Contrainte de structure à imposer si h_act est la vraie hauteur.
            Z3_ast required_stack_structure = Z3_mk_true(ctx);

            //Un seul protocole (4 ou 6) par étage k
            for (int k = 0; k <= h_act; k++) {
                Z3_ast option1 = Z3_mk_and(ctx, 2, (Z3_ast[]){tn_4_variable(ctx, i, k), Z3_mk_not(ctx, tn_6_variable(ctx, i, k))});
                Z3_ast option2 = Z3_mk_and(ctx, 2, (Z3_ast[]){Z3_mk_not(ctx, tn_4_variable(ctx, i, k)), tn_6_variable(ctx, i, k)});
                Z3_ast unique_symbol_k = Z3_mk_or(ctx, 2, (Z3_ast[]){option1, option2});
                
                required_stack_structure = Z3_mk_and(ctx, 2, (Z3_ast[]){required_stack_structure, unique_symbol_k});
            }
            
            for (int k = h_act + 1; k < stack_size; k++) {
                Z3_ast is_empty_k = Z3_mk_and(ctx, 2, (Z3_ast[]){
                    Z3_mk_not(ctx, tn_4_variable(ctx, i, k)), 
                    Z3_mk_not(ctx, tn_6_variable(ctx, i, k))
                });
                
                required_stack_structure = Z3_mk_and(ctx, 2, (Z3_ast[]){required_stack_structure, is_empty_k});
            }
            
            pos_constraints[constraint_count++] = Z3_mk_implies(ctx, x_at_h_act, required_stack_structure);
        }
        // Conjonction de toutes les implications pour l'étape i.
        all_constraints[i] = Z3_mk_and(ctx, constraint_count, pos_constraints);
    }
    // Conjonction de toutes les contraintes    
    return Z3_mk_and(ctx, length + 1, all_constraints);
}

Z3_ast phi5_vertex_operation_link(Z3_context ctx, const TunnelNetwork network, int length) {
    int stack_size = get_stack_size(length);
    int num_nodes = tn_get_num_nodes(network);

    Z3_ast step_constraints[length + 1];

    for (int i = 0; i <= length; i++) {
        Z3_ast constraints_at_i[num_nodes * stack_size * 10];
        int count = 0;

        for (int h = 0; h < stack_size; h++) {
            for (int node = 0; node < num_nodes; node++) {
                // Variable d'état : X_{op, i, h}
                Z3_ast x_node = tn_path_variable(ctx, node, i, h);

                // Vérification des pré-conditions pour chaque type d'action ---

                //Nécessite H(h)=4 au sommet
                if (tn_node_has_action(network, node, transmit_4)) {
                    constraints_at_i[count++] = Z3_mk_implies(ctx, x_node, tn_4_variable(ctx, i, h));
                }
                //Nécessite H(h)=6 au sommet
                if (tn_node_has_action(network, node, transmit_6)) {
                    constraints_at_i[count++] = Z3_mk_implies(ctx, x_node, tn_6_variable(ctx, i, h));
                }
                //Nécessite H(h)=4 au sommet
                if (tn_node_has_action(network, node, push_4_4) || tn_node_has_action(network, node, push_4_6)) {
                    constraints_at_i[count++] = Z3_mk_implies(ctx, x_node, tn_4_variable(ctx, i, h));
                }
                //Nécessite H(h)=6 au sommet
                if (tn_node_has_action(network, node, push_6_4) || tn_node_has_action(network, node, push_6_6)) {
                    constraints_at_i[count++] = Z3_mk_implies(ctx, x_node, tn_6_variable(ctx, i, h));
                }
                //Nécessite H(h)=4 au sommet
                if (tn_node_has_action(network, node, pop_4_4) || tn_node_has_action(network, node, pop_6_4)) {
                    constraints_at_i[count++] = Z3_mk_implies(ctx, x_node, tn_4_variable(ctx, i, h));
                }
                //Nécessite H(h)=6 au sommet
                if (tn_node_has_action(network, node, pop_4_6) || tn_node_has_action(network, node, pop_6_6)) {
                    constraints_at_i[count++] = Z3_mk_implies(ctx, x_node, tn_6_variable(ctx, i, h));
                }
            }
        }

        // Conjonction de toutes les contraintes de l'étape i
        step_constraints[i] = Z3_mk_and(ctx, count, constraints_at_i);
    }
    // Conjonction de toutes les contraintes
    return Z3_mk_and(ctx, length + 1, step_constraints);
}

Z3_ast phi6_stack_dynamics(Z3_context ctx, const TunnelNetwork network, int length) {
    int stack_size = get_stack_size(length);
    int num_nodes = tn_get_num_nodes(network);
    
    Z3_ast all_steps[length];
    
    // tous les positions du chemin
    for (int i = 0; i < length; i++) {
        Z3_ast current_constraints[num_nodes * stack_size * 4]; 
        int count = 0;

        for (int node = 0; node < num_nodes; node++) {
            for (int h = 0; h < stack_size; h++) {
                
                Z3_ast current_state = tn_path_variable(ctx, node, i, h);
                
                //transmit, la pile est conservée
                if (tn_node_has_action(network, node, transmit_4) || tn_node_has_action(network, node, transmit_6)) {
                    Z3_ast preservation_transmit = Z3_mk_true(ctx);
                    // la pile reste identique de k=0 à h
                    for (int k = 0; k <= h; k++) { 
                        Z3_ast preserve_4 = Z3_mk_iff(ctx, tn_4_variable(ctx, i, k), tn_4_variable(ctx, i + 1, k));
                        Z3_ast preserve_6 = Z3_mk_iff(ctx, tn_6_variable(ctx, i, k), tn_6_variable(ctx, i + 1, k));
                        preservation_transmit = Z3_mk_and(ctx, 3, (Z3_ast[]){preservation_transmit, preserve_4, preserve_6});
                    }
                    current_constraints[count++] = Z3_mk_implies(ctx, current_state, preservation_transmit);
                }
                
                //pop, on dépile le sommet
                bool can_pop = tn_node_has_action(network, node, pop_4_4) ||
                               tn_node_has_action(network, node, pop_4_6) ||
                               tn_node_has_action(network, node, pop_6_4) ||
                               tn_node_has_action(network, node, pop_6_6);
                
                if (can_pop) {
                    if (h > 0) {  // pour pas dépiler une pile vide
                        Z3_ast preservation_pop = Z3_mk_true(ctx);
                        
                        // la pile de 0 à h-1 est conservée
                        for (int k = 0; k < h; k++) { 
                            Z3_ast preserve_4 = Z3_mk_iff(ctx, tn_4_variable(ctx, i, k), tn_4_variable(ctx, i + 1, k));
                            Z3_ast preserve_6 = Z3_mk_iff(ctx, tn_6_variable(ctx, i, k), tn_6_variable(ctx, i + 1, k));
                            preservation_pop = Z3_mk_and(ctx, 3, (Z3_ast[]){preservation_pop, preserve_4, preserve_6});
                        }
                        current_constraints[count++] = Z3_mk_implies(ctx, current_state, preservation_pop);
                    }
                }
                
                //push, on rajoute un à la hauteur de pile
                if (h + 1 < stack_size) {  // ne pas dépasser hmax
                    
                    Z3_ast preservation_push = Z3_mk_true(ctx);
                    // la pile de 0 à h est conservée
                    for (int k = 0; k <= h; k++) { 
                        Z3_ast preserve_4 = Z3_mk_iff(ctx, tn_4_variable(ctx, i, k), tn_4_variable(ctx, i + 1, k));
                        Z3_ast preserve_6 = Z3_mk_iff(ctx, tn_6_variable(ctx, i, k), tn_6_variable(ctx, i + 1, k));
                        preservation_push = Z3_mk_and(ctx, 3, (Z3_ast[]){preservation_push, preserve_4, preserve_6});
                    }
                    
                    // push un IPv4
                    if (tn_node_has_action(network, node, push_4_4) || tn_node_has_action(network, node, push_6_4)) {
                        Z3_ast post_condition = Z3_mk_and(ctx, 2, (Z3_ast[]){
                            tn_4_variable(ctx, i + 1, h + 1),  // nouveau sommet IPv4
                            Z3_mk_not(ctx, tn_6_variable(ctx, i + 1, h + 1))  // pas IPv6
                        });
                        Z3_ast full_implication = Z3_mk_implies(ctx, current_state, Z3_mk_and(ctx, 2, (Z3_ast[]){preservation_push, post_condition}));
                        current_constraints[count++] = full_implication;
                    }

                    // push un IPv6
                    if (tn_node_has_action(network, node, push_4_6) || tn_node_has_action(network, node, push_6_6)) {
                         Z3_ast post_condition = Z3_mk_and(ctx, 2, (Z3_ast[]){
                            tn_6_variable(ctx, i + 1, h + 1),  // nouveau sommet IPv6
                            Z3_mk_not(ctx, tn_4_variable(ctx, i + 1, h + 1))  // pas IPv4
                        });
                        Z3_ast full_implication = Z3_mk_implies(ctx, current_state, Z3_mk_and(ctx, 2, (Z3_ast[]){preservation_push, post_condition}));
                        current_constraints[count++] = full_implication;
                    }
                }
            }
        }
        all_steps[i] = Z3_mk_and(ctx, count, current_constraints);
    }
    
    return Z3_mk_and(ctx, length, all_steps);
}

Z3_ast tn_reduction(Z3_context ctx, const TunnelNetwork network, int length) {
    if (length <= 0) return Z3_mk_false(ctx);
    
    Z3_ast phi1 = phi1_unique(ctx, network, length);
    Z3_ast phi2 = phi2_start_end(ctx, network, length);
    Z3_ast phi3 = phi3_complete(ctx, network, length);
    Z3_ast phi4 = phi4_stack_structure(ctx, network, length); 
    Z3_ast phi5 = phi5_vertex_operation_link(ctx, network, length);
    Z3_ast phi6 = phi6_stack_dynamics(ctx, network, length);
    
    Z3_ast constraints[] = {phi1, phi2, phi3, phi4, phi5, phi6};
    Z3_ast result = Z3_mk_and(ctx, 6, constraints);
    
    return result;
}


void tn_get_path_from_model(Z3_context ctx, Z3_model model, TunnelNetwork network, int bound, tn_step *path)
{
    int num_nodes = tn_get_num_nodes(network);
    int stack_size = get_stack_size(bound);
    for (int pos = 0; pos < bound; pos++)
    {
        int src = -1;
        int src_height = -1;
        int tgt = -1;
        int tgt_height = -1;
        for (int n = 0; n < num_nodes; n++)
        {
            for (int height = 0; height < stack_size; height++)
            {
                if (value_of_var_in_model(ctx, model, tn_path_variable(ctx, n, pos, height)))
                {
                    src = n;
                    src_height = height;
                }
                if (value_of_var_in_model(ctx, model, tn_path_variable(ctx, n, pos + 1, height)))
                {
                    tgt = n;
                    tgt_height = height;
                }
            }
        }
        int action = 0;
        if (src_height == tgt_height)
        {
            if (value_of_var_in_model(ctx, model, tn_4_variable(ctx, pos, src_height)))
                action = transmit_4;
            else
                action = transmit_6;
        }
        else if (src_height == tgt_height - 1)
        {
            if (value_of_var_in_model(ctx, model, tn_4_variable(ctx, pos, src_height)))
            {
                if (value_of_var_in_model(ctx, model, tn_4_variable(ctx, pos + 1, tgt_height)))
                    action = push_4_4;
                else
                    action = push_4_6;
            }
            else if (value_of_var_in_model(ctx, model, tn_4_variable(ctx, pos + 1, tgt_height)))
                action = push_6_4;
            else
                action = push_6_6;
        }
        else if (src_height == tgt_height + 1)
        {
            {
                if (value_of_var_in_model(ctx, model, tn_4_variable(ctx, pos, src_height)))
                {
                    if (value_of_var_in_model(ctx, model, tn_4_variable(ctx, pos + 1, tgt_height)))
                        action = pop_4_4;
                    else
                        action = pop_6_4;
                }
                else if (value_of_var_in_model(ctx, model, tn_4_variable(ctx, pos + 1, tgt_height)))
                    action = pop_4_6;
                else
                    action = pop_6_6;
            }
        }
        path[pos] = tn_step_create(action, src, tgt);
    }
}

void tn_print_model(Z3_context ctx, Z3_model model, TunnelNetwork network, int bound)
{
    int num_nodes = tn_get_num_nodes(network);
    int stack_size = get_stack_size(bound);
    for (int pos = 0; pos < bound + 1; pos++)
    {
        printf("At pos %d:\nState: ", pos);
        int num_seen = 0;
        for (int node = 0; node < num_nodes; node++)
        {
            for (int height = 0; height < stack_size; height++)
            {
                if (value_of_var_in_model(ctx, model, tn_path_variable(ctx, node, pos, height)))
                {
                    printf("(%s,%d) ", tn_get_node_name(network, node), height);
                    num_seen++;
                }
            }
        }
        if (num_seen == 0)
            printf("No node at that position !\n");
        else
            printf("\n");
        if (num_seen > 1)
            printf("Several pair node,height!\n");
        printf("Stack: ");
        bool misdefined = false;
        bool above_top = false;
        for (int height = 0; height < stack_size; height++)
        {
            if (value_of_var_in_model(ctx, model, tn_4_variable(ctx, pos, height)))
            {
                if (value_of_var_in_model(ctx, model, tn_6_variable(ctx, pos, height)))
                {
                    printf("|X");
                    misdefined = true;
                }
                else
                {
                    printf("|4");
                    if (above_top)
                        misdefined = true;
                }
            }
            else if (value_of_var_in_model(ctx, model, tn_6_variable(ctx, pos, height)))
            {
                printf("|6");
                if (above_top)
                    misdefined = true;
            }
            else
            {
                printf("| ");
                above_top = true;
            }
        }
        printf("\n");
        if (misdefined)
            printf("Warning: ill-defined stack\n");
    }
    return;
}