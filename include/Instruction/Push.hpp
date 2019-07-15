/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   Push.hpp                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jhache <jhache@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/15 11:49:32 by jhache            #+#    #+#             */
/*   Updated: 2019/07/15 15:34:02 by jhache           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PUSH_HPP
# define PUSH_HPP

# include "IInstruction.hpp"
# include "Operand.hpp"

class Push : public IInstruction
{
public:
	Push();
	Push(IOperand *value);
	Push(Push const &src);
	Push(Push &&src);
	~Push() override;

	Push 	&operator=(Push rhs);

	void	execute(/*My_stack &stack*/) override;

private:
	IOperand	*_value;
};

#endif // PUSH_HPP