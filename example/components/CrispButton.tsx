import React from 'react';
import { Image, StyleSheet, TouchableOpacity } from 'react-native';

interface CrispButtonProps {
  onPress: () => void;
}

const CrispButton = ({ onPress }: CrispButtonProps) => {
  return (
    <TouchableOpacity style={styles.button} onPress={onPress}>
      <Image
        source={require('../assets/images/logo_crisp.png')}
        style={styles.image}
      />
    </TouchableOpacity>
  );
};

export default CrispButton;

const styles = StyleSheet.create({
  button: {
    width: 80,
    height: 80,
    borderRadius: 40,
    overflow: 'hidden',
    justifyContent: 'center',
    alignItems: 'center',
    position: 'relative',
    elevation: 10,
  },
  image: {
    width: '100%',
    height: '100%',
    position: 'absolute',
    top: 0,
    left: 0,
  },
  text: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'center',
    zIndex: 1,
    textShadowColor: 'rgba(0, 0, 0, 0.75)',
    textShadowOffset: { width: -1, height: 1 },
    textShadowRadius: 10,
  },
});
